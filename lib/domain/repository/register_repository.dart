import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:edu_world/data/local/local_data_access.dart';
import 'package:edu_world/di/di.dart';
import 'package:edu_world/domain/response/user_response.dart';
import 'package:edu_world/services/auth_service.dart';

class RegisterRepository {
  final AuthService service = getIt.get();

  final LocalDataAccess _localDataAccess = getIt.get();

  RegisterRepository();

  Future<List<String>> getProvinces() async {
    try {
      final provinces = await service.getProvinces();

      return provinces;
    } catch (e) {
      print(e);
    }

    return [];
  }

  Future<List<String>> getDistricts(String province) async {
    try {
      final districts = await service.getDistricts(province);

      return districts;
    } catch (e) {
      print(e);
    }

    return [];
  }

  Future<List<String>> getSchools(String district) async {
    try {
      final schools = await service.getSchools(district);

      return schools;
    } catch (e) {
      print(e);
    }

    return [];
  }

  Future<bool> register({
    required String name,
    required DateTime birth,
    required String phone,
    required String province,
    required String district,
    required int role,
    required String school,
    required int Class,
  }) async {
    return await service.register(UserResponse(
      id: _localDataAccess.getUserId() ?? '',
      birthday: Timestamp.fromDate(birth),
      district: district,
      grade: Class,
      name: name,
      phone: phone,
      province: province,
      role: role,
      school: school,
      onboarded: false,
    ));
  }
}
