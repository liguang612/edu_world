import 'package:edu_world/domain/response/user_response.dart';
import 'package:edu_world/model/entity/user.dart';

extension UserMapper on UserResponse {
  User toUser() => User(
        id,
        birthday: birthday.toDate(),
        district: district,
        grade: grade,
        name: name,
        province: province,
        role: role,
        school: school,
      );
}
