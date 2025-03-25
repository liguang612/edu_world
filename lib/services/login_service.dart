import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:edu_world/data/constants.dart';
import 'package:edu_world/domain/response/user_response.dart';

class LoginService {
  final _firestore = FirebaseFirestore.instance;

  late final CollectionReference userRef;
  late final CollectionReference vietnamRef;

  LoginService() {
    userRef = _firestore.collection(CollectionKeys.userCollection);
    vietnamRef = _firestore.collection(CollectionKeys.vietnamCollection);
  }

  Future<UserResponse?> getUser(String id) async {
    final res = await userRef.doc(id).get();

    if (res.exists) {
      return UserResponse.fromMap(id, res.data() as Map<String, dynamic>);
    } else {
      return null;
    }
  }
}
