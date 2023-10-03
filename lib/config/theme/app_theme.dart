import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show SystemUiOverlayStyle;
import '../../core/utils/utils.dart';

final class AppTheme {
  AppTheme._();
  static TextTheme lightTextTheme = const TextTheme();

  static ThemeData lightTheme() {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      scaffoldBackgroundColor: AppColors.scaffoldBackgroundColor,
      fontFamily: AppConstants.appFontFamily,
      appBarTheme: AppBarTheme(
        centerTitle: true,
        elevation: 0,
        shadowColor: Colors.transparent,
        backgroundColor: Colors.transparent,
        titleTextStyle: AppTextStyles.medium23.copyWith(
          color: AppColors.corbeau,
          fontWeight: FontWeight.w600,
          fontFamily: AppConstants.appFontFamily,
        ),
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: AppColors.scaffoldBackgroundColor,
          statusBarIconBrightness: Brightness.dark, // For Android (dark icons)
          statusBarBrightness: Brightness.light, // For iOS (dark icons)
        ),
      ),
    );
  }
}
