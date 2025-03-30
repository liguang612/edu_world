import 'package:edu_world/data/local/local_data_access.dart';
import 'package:edu_world/di/di.dart';
import 'package:edu_world/domain/repository/register_repository.dart';
import 'package:edu_world/model/entity/user.dart';
import 'package:edu_world/usecase/base/base_output.dart';

class RegisterUsecase {
  final RegisterRepository _registerRepository = getIt.get();

  final LocalDataAccess _localDataAccess = getIt.get();

  RegisterUsecase();

  Future<RegisterOutput> execute(RegisterInput input) async {
    if (input.birth == null) {
      return const RegisterOutput(successful: false, message: 'Ngày sinh không được để trống');
    } else if (input.province == null) {
      return const RegisterOutput(successful: false, message: 'Vui lòng chọn Tỉnh / Thành phố');
    } else if (input.district == null) {
      return const RegisterOutput(successful: false, message: 'Vui lòng chọn Quận / Huyện');
    } else if (input.role == null) {
      return const RegisterOutput(successful: false, message: 'Bạn là giáo viên hay học sinh?');
    } else if (input.school == null) {
      return const RegisterOutput(successful: false, message: 'Vui lòng chọn Trường học');
    } else if (input.Class == 0) {
      return const RegisterOutput(successful: false, message: 'Vui lòng chọn lớp');
    }

    final state = await _registerRepository.register(
      name: input.name,
      birth: input.birth!,
      phone: input.phone,
      province: input.province!,
      district: input.district!,
      role: input.role!,
      school: input.school!,
      Class: input.Class,
    );

    if (state) {
      return RegisterOutput(
          successful: state,
          user: User(
            _localDataAccess.getUserId() ?? '',
            name: input.name,
            birthday: input.birth!,
            phone: input.phone,
            province: input.province!,
            district: input.district!,
            role: input.role!,
            school: input.school!,
            grade: input.Class,
          ));
    } else {
      return const RegisterOutput(successful: false, message: 'Có lỗi xảy ra, vui lòng thử lại');
    }
  }
}

class RegisterInput {
  final String name;
  final DateTime? birth;
  final String phone;
  final String? province;
  final String? district;
  final int? role;
  final String? school;
  final int Class;

// ignore: non_constant_identifier_names
  RegisterInput({
    required this.name,
    this.birth,
    required this.phone,
    this.province,
    this.district,
    this.role,
    this.school,
    required this.Class,
  });
}

class RegisterOutput extends BaseOutput {
  final User? user;

  const RegisterOutput({
    super.message,
    super.successful,
    this.user,
  });
}
