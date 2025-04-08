import 'package:edu_world/data/local/local_data_access.dart';
import 'package:edu_world/di/di.dart';
import 'package:edu_world/domain/repository/course_repository.dart';
import 'package:edu_world/domain/repository/login_repository.dart';
import 'package:edu_world/model/entity/course.dart';
import 'package:edu_world/usecase/base/base_output.dart';

class GetCoursesUsecase {
  final CourseRepository _courseRepository = getIt.get();
  final LoginRepository _loginRepository = getIt.get();

  final LocalDataAccess _localDataAccess = getIt.get();

  Future<GetCoursesOutput> execute() async {
    final userId = _localDataAccess.getUserId();
    if (userId == null) {
      return const GetCoursesOutput(
        courses: [],
        message: 'Không tìm thấy ID người dùng (404)',
        successful: false,
      );
    }

    int? role = _localDataAccess.getRole();
    if (role == null) {
      final user = await _loginRepository.findUser(userId);

      if (user == null) {
        return const GetCoursesOutput(
          courses: [],
          message: 'Không tìm thấy ID người dùng (404)',
          successful: false,
        );
      } else {
        role = user.role;
      }
    }

    final response = await _courseRepository.getCourses(userId, role);
    return GetCoursesOutput(courses: response, successful: true);
  }
}

class GetCoursesOutput extends BaseOutput {
  final List<Course> courses;

  const GetCoursesOutput({super.message, super.successful, required this.courses});
}
