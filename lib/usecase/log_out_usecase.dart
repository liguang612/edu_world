import 'package:edu_world/di/di.dart';
import 'package:edu_world/services/auth_service.dart';
import 'package:edu_world/usecase/base/base_output.dart';

class LogOutUsecase {
  final AuthService _authService = getIt.get();

  Future<LogOutOutput> execute() async {
    final response = await _authService.logOut();

    return LogOutOutput(successful: response);
  }
}

class LogOutOutput extends BaseOutput {
  const LogOutOutput({super.successful});
}
