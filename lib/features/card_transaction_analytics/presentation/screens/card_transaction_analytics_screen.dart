import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_task/core/utils/utils.dart';
import 'package:flutter_task/features/card_transaction_analytics/presentation/cubit/card_transaction_analytics_cubit.dart';
import 'package:flutter_task/features/card_transaction_analytics/presentation/widgets/widgets.dart';

class CardTransactionAnalyticsScreen extends StatelessWidget {
  const CardTransactionAnalyticsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarWidget(),
      body: BlocConsumer<CardTransactionAnalyticsCubit,
          CardTransactionAnalyticsState>(
        listener: (context, state) {
          final cubit = context.read<CardTransactionAnalyticsCubit>();
          if (state is GroupByChangedState) {
            cubit.generateAndFormatTimePeriodsFun(
              state.groubBy,
              AppConstants.initialDate,
            );
          }
        },
        builder: (context, state) {
          final cubit = context.read<CardTransactionAnalyticsCubit>();
          return ListView(
            padding: const EdgeInsets.fromLTRB(0, 0, 0, Sizes.s16),
            children: [
              // GroubBy (week - month - year)
              const GroupByWidget(),
              //Pie chart and Total Spent
              Container(
                constraints: BoxConstraints(
                  maxWidth: MediaQuery.of(context).size.width * 0.7,
                  maxHeight: MediaQuery.of(context).size.height * 0.4,
                ),
                child: Stack(
                  children: [
                    PieChartWidget(cubit: cubit),
                    if (cubit.response != null) TotalSpentWidget(cubit: cubit),
                  ],
                ),
              ),
              // Time Period Switcher
              if (cubit.timePeriodsList.isNotEmpty)
                TimePeriodWidget(
                  cubit: cubit,
                ),
              //Bar Chart And Expenses Categories

              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: Sizes.s14,
                ),
                child: Stack(
                  children: [
                    BarChartWidget(
                      cubit: cubit,
                    ),
                    if (cubit.response != null)
                      ExpenseCategoriesWidget(cubit: cubit),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
