import 'package:flutter_task/app_injector.dart';
import 'package:flutter_task/features/card_transaction_analytics/presentation/cubit/card_transaction_analytics_cubit.dart';

class CardTransactionAnalyticsInjector {
  static void init() {
    sl.registerFactory(() => CardTransactionAnalyticsCubit());

    //use cases

    //repository

    //data sources
  }
}
