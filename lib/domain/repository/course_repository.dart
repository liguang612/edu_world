import 'package:edu_world/di/di.dart';
import 'package:edu_world/model/entity/course.dart';
import 'package:edu_world/model/entity/subject.dart';
import 'package:edu_world/model/mapper/subject_mapper.dart';
import 'package:edu_world/services/course_service.dart';

class CourseRepository {
  final CourseService _subjectService = getIt.get();

  CourseRepository();

  Future<List<Subject>> getSubjects({int? grade}) async {
    try {
      final response = await _subjectService.getSubjects(grade: grade);

      return response.map((e) => e.toSubject()).toList();
    } catch (e) {
      print(e);
    }

    return [];
  }

  Future<List<Course>> getCourses() async {}
}
