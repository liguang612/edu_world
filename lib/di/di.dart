import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;

configureInjection() async {
  // final sharedPref = await SharedPreferences.getInstance();

  // Local
  // getIt.registerLazySingleton<LocalDataAccess>(() => SharePrefHelper(sharedPref));

  // Databae
  // getIt.registerLazySingleton(() => DatabaseServices());
}
