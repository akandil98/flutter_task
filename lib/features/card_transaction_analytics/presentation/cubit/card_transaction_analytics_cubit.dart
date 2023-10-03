import 'dart:developer';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_task/core/utils/utils.dart';
import 'package:flutter_task/features/card_transaction_analytics/domain/entities/response.dart';
import 'package:flutter_task/features/card_transaction_analytics/domain/entities/time_period.dart';
import 'package:flutter_task/isar_service.dart';
import 'package:intl/intl.dart';

part 'card_transaction_analytics_state.dart';

class CardTransactionAnalyticsCubit
    extends Cubit<CardTransactionAnalyticsState> {
  CardTransactionAnalyticsCubit() : super(CardTransactionAnalyticsInitial());

  final IsarService isarService = IsarService();
  String groupBy = AppConstants.month;

  List<TimePeriod> timePeriodsList = [];
  void changeGroupByFun({required String groupBy}) async {
    currentTimePeriodIndex = 0;
    timePeriodsList = [];
    timePeriodsList = generateAndFormatTimePeriodsFun(
      groupBy,
      AppConstants.initialDate,
    );
    await expensesCalculationFun(
      startDate: timePeriodsList[currentTimePeriodIndex].startDate,
      endDate: timePeriodsList[currentTimePeriodIndex].endDate,
    );
    this.groupBy = groupBy;
    emit(GroupByChangedState(groubBy: groupBy));
  }

  List<TimePeriod> generateAndFormatTimePeriodsFun(
    String selection,
    DateTime initialDateTime,
  ) {
    final timePeriods = <TimePeriod>[];
    final currentDateTime = DateTime.now();

    while (initialDateTime.isBefore(currentDateTime) ||
        initialDateTime.isAtSameMomentAs(currentDateTime)) {
      final startDateTime = initialDateTime;
      final endDateTime = selection == AppConstants.week
          ? startDateTime.add(const Duration(days: 6))
          : DateTime(
              startDateTime.year,
              startDateTime.month + 1,
              1,
            ).subtract(const Duration(days: 1));

      final currentYear = currentDateTime.year;
      final currentMonth = currentDateTime.month;

      TimePeriod formattedPeriod;

      if (selection == AppConstants.week) {
        formattedPeriod =
            TimePeriod(startDate: startDateTime, endDate: endDateTime);
      } else if (selection == AppConstants.month) {
        if (startDateTime.year == currentYear &&
            startDateTime.month == currentMonth) {
          final endOfMonth = currentDateTime;
          final startOfMonth = DateTime(currentYear, currentMonth);
          formattedPeriod =
              TimePeriod(startDate: startOfMonth, endDate: endOfMonth);
        } else {
          formattedPeriod =
              TimePeriod(startDate: startDateTime, endDate: endDateTime);
        }
      } else if (selection == AppConstants.year) {
        final year = startDateTime.year;
        final startOfYear = DateTime(year);
        final endOfYear = DateTime(year + 1).subtract(const Duration(days: 1));
        formattedPeriod =
            TimePeriod(startDate: startOfYear, endDate: endOfYear);
      } else {
        formattedPeriod =
            TimePeriod(startDate: DateTime(0), endDate: DateTime(0));
      }

      timePeriods.add(formattedPeriod);

      if (selection == AppConstants.week) {
        initialDateTime = initialDateTime.add(const Duration(days: 7));
      } else if (selection == AppConstants.month) {
        initialDateTime = DateTime(
          initialDateTime.year,
          initialDateTime.month + 1,
          1,
        );
      } else if (selection == AppConstants.year) {
        initialDateTime = DateTime(
          initialDateTime.year + 1,
          1,
          1,
        );
      }
    }

    // Reverse the time periods to display them in descending order
    final reversedTimePeriods = List<TimePeriod>.from(timePeriods.reversed);
    for (var timePeriod in reversedTimePeriods) {
      log(timePeriod.startDate.toString() + timePeriod.endDate.toString());
    }
    timePeriodsList = reversedTimePeriods;
    return reversedTimePeriods;
  }

  Response? response;
  Future<void> initExpensesCalculationFun() async {
    emit(InitCalculationLoadingState());
    timePeriodsList = generateAndFormatTimePeriodsFun(
      AppConstants.month,
      AppConstants.initialDate,
    );
    response = await isarService.calculateExpensesBetween(
      DateTime(DateTime.now().year, DateTime.now().month, 1),
      DateTime.now(),
    );
    //! mocking api delay for testing animations
    await Future.delayed(const Duration(seconds: 3));
    if (response != null) {
      emit(InitCalculationLoadedState(response: response!));
    }
  }

  Future<void> expensesCalculationFun({
    required DateTime startDate,
    required DateTime endDate,
  }) async {
    emit(ExpensesCalculationLoadingState());
    response = await isarService.calculateExpensesBetween(
      startDate,
      endDate,
    );

    if (response != null) {
      emit(ExpensesCalculationLoadedState(response: response!));
    }
  }

  //! timeperiod switcher
  int currentTimePeriodIndex = 0;

  void goToPrevious() async {
    log(currentTimePeriodIndex.toString());
    if (currentTimePeriodIndex < timePeriodsList.length - 1) {
      currentTimePeriodIndex++;
      await expensesCalculationFun(
        startDate: timePeriodsList[currentTimePeriodIndex].startDate,
        endDate: timePeriodsList[currentTimePeriodIndex].endDate,
      );

      emit(GoToPreviousTimePeriodState(index: currentTimePeriodIndex));
    }
  }

  void goToNext() async {
    log(currentTimePeriodIndex.toString());
    if (currentTimePeriodIndex > 0) {
      currentTimePeriodIndex--;
      await expensesCalculationFun(
        startDate: timePeriodsList[currentTimePeriodIndex].startDate,
        endDate: timePeriodsList[currentTimePeriodIndex].endDate,
      );

      emit(GoToNextTimePeriodState(index: currentTimePeriodIndex));
    }
  }

  //! format time period
  String formatDateTimeRange(
      DateTime startDate, DateTime endDate, String groupType) {
    final now = DateTime.now();

    if (groupType == 'week') {
      if (startDate.year == now.year &&
          startDate.month == now.month &&
          startDate.day == now.day) {
        return 'This week';
      } else if (startDate.year == now.year) {
        return '${startDate.month.toString().padLeft(2, '0')}-${startDate.day.toString().padLeft(2, '0')} \n${endDate.month.toString().padLeft(2, '0')}-${endDate.day.toString().padLeft(2, '0')}';
      } else {
        return '${startDate.year}-${startDate.month.toString().padLeft(2, '0')}-${startDate.day.toString().padLeft(2, '0')} \n${endDate.year}-${endDate.month.toString().padLeft(2, '0')}-${endDate.day.toString().padLeft(2, '0')}';
      }
    } else if (groupType == 'month') {
      if (startDate.year == now.year && startDate.month == now.month) {
        return 'This month';
      } else if (startDate.year == now.year) {
        return DateFormat('MMMM').format(startDate);
      } else {
        return '${startDate.year} ${DateFormat('MMMM').format(startDate)}';
      }
    } else if (groupType == 'year') {
      if (startDate.year == now.year) {
        return 'This year';
      } else {
        return startDate.year.toString();
      }
    } else {
      return ''; // Handle unsupported groupType if needed
    }
  }

  //! toggle bar animation
  bool isTapped = false;
  int barChartIndex = -1;
  void toggleOnBarChartAnimation({required int barChartIndex}) {
    this.barChartIndex = barChartIndex;
    isTapped = true;
    emit(BarChartAnimationToggledOnState(index: barChartIndex));
    // isTapped = false;
    // barChartIndex = -1;
  }

  void toggleOffBarChartAnimation({required int barChartIndex}) {
    isTapped = false;
    barChartIndex = -1;
    emit(BarChartAnimationToggledOffState(index: barChartIndex));
  }
}
