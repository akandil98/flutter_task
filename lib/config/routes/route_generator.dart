import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_task/config/routes/routes.dart';
import 'package:flutter_task/core/utils/utils.dart';
import 'package:flutter_task/features/card_transaction_analytics/presentation/cubit/card_transaction_analytics_cubit.dart';
import 'package:flutter_task/features/card_transaction_analytics/presentation/screens/card_transaction_analytics_screen.dart';
import 'package:flutter_task/features/splash/presentation/screens/splash_screen.dart';
import 'package:flutter_task/app_injector.dart' as di;

final class RouteGenerator {
  RouteGenerator._();
  static Route<dynamic> getRoute(RouteSettings routeSettings) {
// ignore: unused_local_variable
    final args = routeSettings.arguments;
    switch (routeSettings.name) {
      case AppRoutes.initialRoute:
        return MaterialPageRoute(
          builder: (BuildContext context) => const SplashScreen(),
        );
      case AppRoutes.cardTransactionAnalyticsScreen:
        return MaterialPageRoute(
          builder: (BuildContext context) => BlocProvider(
            create: (context) => di.sl<CardTransactionAnalyticsCubit>()
              ..initExpensesCalculationFun(),
            child: const CardTransactionAnalyticsScreen(),
          ),
        );
      default:
        return unDefinedRoute();
    }
  }

  static Route<dynamic> unDefinedRoute() {
    return MaterialPageRoute(
      builder: (_) => const Scaffold(
        body: Center(
          child: Text(
            AppStrings.undefinedRoute,
          ),
        ),
      ),
    );
  }
}
