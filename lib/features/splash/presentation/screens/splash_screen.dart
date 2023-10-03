import 'package:flutter/material.dart';
import 'package:flutter_task/config/routes/routes.dart';
import 'package:flutter_task/core/utils/utils.dart';
import 'package:flutter_task/isar_service.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final IsarService isarService = IsarService();
  @override
  void initState() {
    super.initState();

    _gotToLandingScreen();
  }

  void _gotToLandingScreen() async {
    await Future.delayed(
      const Duration(seconds: AppConstants.splashDelay),
      () => _goToLogin(),
    );
  }

  void _goToLogin() {
    AppNavigator.navigateNamedReplace(
        context, AppRoutes.cardTransactionAnalyticsScreen);
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text(AppStrings.helloWorld),
      ),
    );
  }
}
