import 'package:edu_world/di/di.dart';
import 'package:edu_world/domain/response/subject_response.dart';
import 'package:edu_world/model/entity/course.dart';
import 'package:edu_world/model/entity/review.dart';
import 'package:edu_world/model/entity/subject.dart';
import 'package:edu_world/model/mapper/course_mapper.dart';
import 'package:edu_world/model/mapper/subject_mapper.dart';
import 'package:edu_world/services/course_service.dart';

class CourseRepository {
  final CourseService _courseService = getIt.get();

  CourseRepository();

  Future<List<Course>> getCourses(String userId, int role) async {
    try {
      final subjects = await _courseService.getSubjects();

      final response = await _courseService.getCourses(userId, role);

      return response
          .map((e) => e.toCourse(
                subject: subjects
                    .firstWhere(
                      (element) => element.id == e.subjectId,
                      orElse: () => SubjectResponse.emptyResponse,
                    )
                    .toSubject(),
              ))
          .toList();
    } catch (e) {
      print(e);
    }

    return [];
  }

  Future<List<Review>> getReviews(String courseId) async {
    return await _courseService.getReviews(courseId);
  }

  Future<List<Subject>> getSubjects({int? grade}) async {
    try {
      final response = await _courseService.getSubjects(grade: grade);

      return response.map((e) => e.toSubject()).toList();
    } catch (e) {
      print(e);
    }

    return [];
  }
}
