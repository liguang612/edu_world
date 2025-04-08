import 'package:edu_world/di/di.dart';
import 'package:edu_world/domain/repository/course_repository.dart';
import 'package:edu_world/model/entity/course.dart';
import 'package:edu_world/usecase/base/base_output.dart';

class GetCoursesUsecase {
  final CourseRepository _courseRepository = getIt.get();

  Future<GetCoursesOutput> execute() async {
    final response = _courseRepository.
  }
}

class GetCoursesOutput extends BaseOutput {
  final List<Course> courses;

  const GetCoursesOutput({super.message, super.successful, required this.courses});
}
