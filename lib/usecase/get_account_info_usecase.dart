import 'package:edu_world/data/local/local_data_access.dart';
import 'package:edu_world/di/di.dart';
import 'package:edu_world/domain/repository/login_repository.dart';
import 'package:edu_world/model/entity/user.dart';
import 'package:edu_world/usecase/base/base_output.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase;

class GetAccountInfoUsecase {
  final LoginRepository _loginRepository = getIt.get();

  final LocalDataAccess _localDataAccess = getIt.get();

  Future<GetAccountInfoOutput> execute() async {
    final response = await _loginRepository.findUser(_localDataAccess.getUserId() ?? '');

    if (response != null) {
      return GetAccountInfoOutput(
        user: response
          ..avatarUrl = firebase.FirebaseAuth.instance.currentUser?.photoURL
          ..email = firebase.FirebaseAuth.instance.currentUser?.email,
        successful: true,
      );
    }

    return const GetAccountInfoOutput(successful: false);
  }
}

class GetAccountInfoOutput extends BaseOutput {
  final User? user;

  const GetAccountInfoOutput({
    super.successful,
    super.message,
    this.user,
  });
}
