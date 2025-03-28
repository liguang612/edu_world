import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:edu_world/data/constants.dart';
import 'package:edu_world/domain/response/user_response.dart';

class AuthService {
  final _firestore = FirebaseFirestore.instance;

  late final CollectionReference userRef;
  late final CollectionReference vietnamRef;

  late DocumentReference provinceRef;
  late DocumentReference districtRef;

  AuthService() {
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

  Future<List<String>> getProvinces() async {
    final res = await vietnamRef.get();

    return res.docs.map((e) => e.id).toList();
  }

  Future<List<String>> getDistricts(String province) async {
    provinceRef = vietnamRef.doc(province);
    final res = await vietnamRef.doc(province).collection(CollectionKeys.districtCollection).get();

    return res.docs.map((e) => e.id).toList();
  }

  Future<List<String>> getSchools(String district) async {
    districtRef = provinceRef.collection(CollectionKeys.districtCollection).doc(district);
    final res = await districtRef.get();

    final rawData = (res.data() as Map<String, dynamic>)["schools"] as List<dynamic>;

    return rawData.map((e) => e.toString()).toList();
  }

  Future<bool> register({
    required String id,
    required String name,
    required Timestamp birth,
    required String phone,
    required String province,
    required String district,
    required int role,
    required String school,
    required int Class,
  }) async {
    try {
      await userRef.doc(id).set({
        'name': name,
        'birth': birth,
        'phone': phone,
        'province': province,
        'district': district,
        'role': role,
        'school': school,
        'class': Class,
      });

      return true;
    } catch (e) {
      print('\n\n\nLOGGING: Register failed: $e \n\n\n');
    }
    return false;
  }
}
