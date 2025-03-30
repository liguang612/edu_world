import 'package:edu_world/di/di.dart';
import 'package:edu_world/domain/repository/login_repository.dart';
import 'package:edu_world/usecase/base/base_output.dart';

class LogOutUsecase {
  final LoginRepository _loginRepository = getIt.get();

  Future<LogOutOutput> execute() async {
    final response = await _loginRepository.logout();

    return LogOutOutput(successful: response);
  }
}

class LogOutOutput extends BaseOutput {
  const LogOutOutput({super.successful});
}
