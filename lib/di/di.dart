import 'package:edu_world/bloc/login/login_bloc.dart';
import 'package:edu_world/bloc/register/register_bloc.dart';
import 'package:edu_world/data/local/local_data_access.dart';
import 'package:edu_world/data/local/shared_preferences.dart';
import 'package:edu_world/domain/repository/login_repository.dart';
import 'package:edu_world/domain/repository/register_repository.dart';
import 'package:edu_world/services/auth_service.dart';
import 'package:edu_world/usecase/get_classes_usecase.dart';
import 'package:edu_world/usecase/login_usecase.dart';
import 'package:edu_world/usecase/register_usecase.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

final getIt = GetIt.instance;

configureInjection() async {
  final sharedPref = await SharedPreferences.getInstance();

  // Local
  getIt.registerLazySingleton<LocalDataAccess>(() => SharePrefHelper(sharedPref));

  // Database
  getIt.registerLazySingleton(() => AuthService());

  // Repository
  getIt.registerLazySingleton(() => LoginRepository());
  getIt.registerLazySingleton(() => RegisterRepository());

  // Usecase
  getIt.registerLazySingleton(() => LoginUsecase());
  getIt.registerLazySingleton(() => GetClassesUsecase());
  getIt.registerLazySingleton(() => RegisterUsecase());

  // Bloc
  getIt.registerLazySingleton(() => LoginBloc());
  getIt.registerLazySingleton(() => RegisterBloc());
}
