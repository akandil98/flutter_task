import 'package:flutter_task/features/card_transaction_analytics/card_transaction_analytics_injector.dart';
import 'package:get_it/get_it.dart';

GetIt sl = GetIt.instance;

class AppInjector {
  static Future<void> init() async {
    // Features Injectors
    CardTransactionAnalyticsInjector.init();

    // Core
    // sl.registerLazySingleton<NetworkInfo>(
    //     () => NetworkInfoImpl(internetConnectionChecker: sl()));
    // sl.registerLazySingleton<ApiConsumer>(() => DioConsumer(client: sl()));

    // External
    // final sharedPreferences = await SharedPreferences.getInstance();
    // sl.registerLazySingleton(() => sharedPreferences);

    // sl.registerLazySingleton(() => AppInterceptors());

    // sl.registerLazySingleton(() => LogInterceptor(
    //       request: true,
    //       requestBody: true,
    //       responseBody: true,
    //       responseHeader: true,
    //       requestHeader: true,
    //       error: true,
    //     ));

    // sl.registerLazySingleton(() => InternetConnectionChecker());

    // sl.registerLazySingleton(() => Dio());
  }
}
