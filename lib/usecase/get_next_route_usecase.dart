import 'package:edu_world/config/routes.dart';
import 'package:edu_world/data/local/local_data_access.dart';
import 'package:edu_world/di/di.dart';
import 'package:edu_world/model/mapper/user_mapper.dart';
import 'package:edu_world/services/auth_service.dart';
import 'package:edu_world/usecase/base/base_output.dart';

class GetNextRouteUsecase {
  final AuthService _authService = getIt.get();

  final LocalDataAccess _localDataAccess = getIt.get();

  Future<GetNextRouteOutput> execute() async {
    final userId = _localDataAccess.getUserId();

    if (userId != null) {
      final res = await _authService.getUser(userId);

      if (res != null) {
        if (res.onboarded) {
          return GetNextRouteOutput(
            arguments: HomepageArgs(res.toUser()),
            nextRoute: AppRoute.home,
            successful: true,
          );
        } else {
          return GetNextRouteOutput(
            arguments: HomepageArgs(res.toUser()),
            nextRoute: AppRoute.onboarding,
            successful: true,
          );
        }
      } else {
        return const GetNextRouteOutput(nextRoute: AppRoute.register, successful: true);
      }
    } else {
      return const GetNextRouteOutput(nextRoute: AppRoute.login, successful: true);
    }
  }
}

class GetNextRouteOutput extends BaseOutput {
  final String nextRoute;
  final dynamic arguments;

  const GetNextRouteOutput({
    super.successful,
    super.message,
    this.arguments,
    required this.nextRoute,
  });
}
