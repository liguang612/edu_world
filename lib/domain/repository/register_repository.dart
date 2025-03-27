import 'package:edu_world/di/di.dart';
import 'package:edu_world/services/auth_service.dart';

class RegisterRepository {
  final AuthService service = getIt.get();

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
}
