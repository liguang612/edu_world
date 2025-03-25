import 'package:edu_world/di/di.dart';
import 'package:edu_world/domain/repository/login_repository.dart';
import 'package:edu_world/model/entity/user.dart';
import 'package:edu_world/usecase/base/base_output.dart';

class LoginUsecase {
  final LoginRepository loginRepository = getIt.get();

  LoginUsecase();

  Future<LoginUsecaseOutput> execute() async {
    final userId = await loginRepository.logInWithGoogle();

    // Login failed
    if (userId == null) return const LoginUsecaseOutput(successful: false);

    // Find user
    final user = await loginRepository.findUser(userId);

    if (user != null) {
      return LoginUsecaseOutput(successful: true, user: user);
    } else {
      // If login successfully but not found user -> register
      return LoginUsecaseOutput(successful: true, id: userId);
    }
  }
}

class LoginUsecaseOutput extends BaseOutput {
  final User? user;
  final String? id;

  const LoginUsecaseOutput({super.successful, this.id, this.user});
}
