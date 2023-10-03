part of 'card_transaction_analytics_cubit.dart';

abstract class CardTransactionAnalyticsState extends Equatable {
  const CardTransactionAnalyticsState();

  @override
  List<Object> get props => [];
}

class CardTransactionAnalyticsInitial extends CardTransactionAnalyticsState {}

class GroupByChangedState extends CardTransactionAnalyticsState {
  final String groubBy;

  const GroupByChangedState({required this.groubBy});
  @override
  List<Object> get props => [groubBy];
}

class InitCalculationLoadingState extends CardTransactionAnalyticsState {}

class InitCalculationLoadedState extends CardTransactionAnalyticsState {
  final Response response;

  const InitCalculationLoadedState({required this.response});
  @override
  List<Object> get props => [response];
}

class ExpensesCalculationLoadingState extends CardTransactionAnalyticsState {}

class ExpensesCalculationLoadedState extends CardTransactionAnalyticsState {
  final Response response;

  const ExpensesCalculationLoadedState({required this.response});
  @override
  List<Object> get props => [response];
}

class GoToPreviousTimePeriodState extends CardTransactionAnalyticsState {
  final int index;

  const GoToPreviousTimePeriodState({required this.index});
  @override
  List<Object> get props => [index];
}

class GoToNextTimePeriodState extends CardTransactionAnalyticsState {
  final int index;

  const GoToNextTimePeriodState({required this.index});
  @override
  List<Object> get props => [index];
}

class BarChartAnimationToggledOnState extends CardTransactionAnalyticsState {
  final int index;

  const BarChartAnimationToggledOnState({required this.index});
  @override
  List<Object> get props => [index];
}

class BarChartAnimationToggledOffState extends CardTransactionAnalyticsState {
  final int index;

  const BarChartAnimationToggledOffState({required this.index});
  @override
  List<Object> get props => [index];
}
