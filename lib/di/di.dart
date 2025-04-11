import 'package:edu_world/bloc/account/account_bloc.dart';
import 'package:edu_world/bloc/course/course_bloc.dart';
import 'package:edu_world/bloc/course/create/create_course_bloc.dart';
import 'package:edu_world/bloc/course/list/course_list_bloc.dart';
import 'package:edu_world/bloc/login/login_bloc.dart';
import 'package:edu_world/bloc/onboarding/onboarding_bloc.dart';
import 'package:edu_world/bloc/register/register_bloc.dart';
import 'package:edu_world/bloc/splash/splash_bloc.dart';
import 'package:edu_world/data/local/local_data_access.dart';
import 'package:edu_world/data/local/shared_preferences.dart';
import 'package:edu_world/domain/repository/course_repository.dart';
import 'package:edu_world/domain/repository/login_repository.dart';
import 'package:edu_world/domain/repository/register_repository.dart';
import 'package:edu_world/services/auth_service.dart';
import 'package:edu_world/services/course_service.dart';
import 'package:edu_world/services/lecture_service.dart';
import 'package:edu_world/services/storage_service.dart';
import 'package:edu_world/usecase/create_course_usecase.dart';
import 'package:edu_world/usecase/edit_course_usecase.dart';
import 'package:edu_world/usecase/get_account_info_usecase.dart';
import 'package:edu_world/usecase/get_classes_usecase.dart';
import 'package:edu_world/usecase/get_courses_usecase.dart';
import 'package:edu_world/usecase/get_next_route_usecase.dart';
import 'package:edu_world/usecase/get_reviews_score_usecase.dart';
import 'package:edu_world/usecase/log_out_usecase.dart';
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
  getIt.registerLazySingleton(() => CourseService());
  getIt.registerLazySingleton(() => LectureService());
  getIt.registerLazySingleton(() => StorageService());

  // Repository
  getIt.registerLazySingleton(() => CourseRepository());
  getIt.registerLazySingleton(() => LoginRepository());
  getIt.registerLazySingleton(() => RegisterRepository());

  // Usecase
  getIt.registerLazySingleton(() => CreateCourseUsecase());
  getIt.registerLazySingleton(() => EditCourseUsecase());
  getIt.registerLazySingleton(() => GetAccountInfoUsecase());
  getIt.registerLazySingleton(() => GetClassesUsecase());
  getIt.registerLazySingleton(() => GetCoursesUsecase());
  getIt.registerLazySingleton(() => GetNextRouteUsecase());
  getIt.registerLazySingleton(() => GetReviewsScoreUsecase());
  getIt.registerLazySingleton(() => LoginUsecase());
  getIt.registerLazySingleton(() => LogOutUsecase());
  getIt.registerLazySingleton(() => RegisterUsecase());

  // Bloc
  getIt.registerLazySingleton(() => AccountBloc());
  getIt.registerLazySingleton(() => CourseBloc());
  getIt.registerLazySingleton(() => CourseListBloc());
  getIt.registerLazySingleton(() => CreateCourseBloc());
  getIt.registerLazySingleton(() => LoginBloc());
  getIt.registerLazySingleton(() => OnboardingBloc());
  getIt.registerLazySingleton(() => RegisterBloc());
  getIt.registerLazySingleton(() => SplashBloc());
}
