import 'package:edu_world/data/local/local_data_access.dart';
import 'package:edu_world/di/di.dart';
import 'package:edu_world/model/entity/user.dart' as entity;
import 'package:edu_world/model/mapper/user_mapper.dart';
import 'package:edu_world/services/auth_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class LoginRepository {
  final AuthService service = getIt.get();
  final GoogleSignIn googleSignIn = GoogleSignIn(scopes: [
    'email',
    'https://www.googleapis.com/auth/admin.directory.customer.readonly',
  ]);

  final LocalDataAccess localDataAccess = getIt.get();

  LoginRepository();

  Future<String?> logInWithGoogle() async {
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

        return userCredential.user?.uid;
      } else {
        return null;
      }
    } catch (e) {
      print('GOOGLE_SIGN_IN_ERROR: $e');
    }

    return null;
  }

  Future<entity.User?> findUser(String id) async {
    try {
      final user = await service.getUser(id);
      if (user != null) {
        return user.toUser();
      }
    } catch (e) {
      print(e);
    }
    return null;
  }

  Future<void> logout() async {
    try {
      await FirebaseAuth.instance.signOut();
      await googleSignIn.disconnect();

      localDataAccess.clearAccessToken();
      localDataAccess.clearUserId();
    } catch (e) {
      print('LOGOUT_ERROR: $e');
    }
  }
}
