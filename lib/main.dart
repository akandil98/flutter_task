import 'package:bloc/bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show SystemChrome, DeviceOrientation;
import 'package:flutter_task/app_injector.dart';
import 'package:flutter_task/core/utils/my_bloc_observer.dart';
import 'package:flutter_task/isar_service.dart';
import 'app.dart';
import 'core/utils/app_constants.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await AppInjector.init();
  await IsarService().cleanDb();
  await IsarService().addExpenses();
  Bloc.observer = MyBlocObserver();
  const arLocale = Locale(AppConstants.arCode);
  const enLocale = Locale(AppConstants.enCode);

  /// Lock device orientation to portrait
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  runApp(
    EasyLocalization(
      supportedLocales: const [
        arLocale,
        enLocale,
      ],
      path: AppConstants.languagePath,
      fallbackLocale: enLocale,
      saveLocale: true,
      startLocale: enLocale,
      child: const App(),
    ),
  );
}
