import 'package:edu_world/data/local/local_data_access.dart';
import 'package:edu_world/di/di.dart';
import 'package:edu_world/domain/base/response_wrapper.dart';
import 'package:edu_world/mdoel/account.dart';
import 'package:edu_world/model/mapper/account_mapper.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class LoginRepository {
  final LocalDataAccess localDataAccess = getIt.get();

  final GoogleSignIn googleSignIn = GoogleSignIn(scopes: [
    'email',
    'https://www.googleapis.com/auth/admin.directory.customer.readonly',
  ]);

  LoginRepository();

  Future<ResponseWrapper<Account>> logInWithGoogle() async {
    try {
      // Show the sign in and select Google account
      final account = await googleSignIn.signIn();

      if (account != null) {
        // Details of user
        final authentication = await account.authentication;

        // Create a new credential for user
        final credential = GoogleAuthProvider.credential(
          accessToken: authentication.accessToken,
          idToken: authentication.idToken,
        );

        final userCredential = await FirebaseAuth.instance.signInWithCredential(credential);

        localDataAccess.setAccessToken(authentication.accessToken ?? '');
        localDataAccess.setUserId(userCredential.user?.uid ?? '');

        return ResponseWrapper.success(data: userCredential.user.toAccount());
      } else {
        return ResponseWrapper.error(message: 'Đăng nhập thất bại');
      }
    } catch (e) {
      print('GOOGLE_SIGN_IN_ERROR: $e');
    }

    return ResponseWrapper.error(message: 'Lỗi không xác định');
  }

  Future<ResponseWrapper<void>> logout() async {
    try {
      await FirebaseAuth.instance.signOut();
      await googleSignIn.disconnect();

      localDataAccess.clearAccessToken();
      localDataAccess.clearUserId();

      return ResponseWrapper.success(data: null);
    } catch (e) {
      print('LOGOUT_ERROR: $e');
    }

    return ResponseWrapper.error(message: 'Đăng xuất thất bại');
  }
}
