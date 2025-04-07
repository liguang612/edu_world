import 'package:edu_world/domain/response/course_response.dart';
import 'package:edu_world/model/entity/course.dart';

extension CourseMapper on CourseResponse {
  Course toCourse() {
    return Course(
      description: description,
      name: name,
      subjectId: subjectId,
      tAIds: tAIds ?? [],
      teacherId: teacherId,
      visible: visible,
      wallpaper: wallpaper,
    );
  }
}

extension CourseResponseMapper on Course {
  CourseResponse toCourseResponse() {
    return CourseResponse(
      description: description,
      name: name,
      subjectId: subjectId,
      teacherId: teacherId,
      visible: visible,
      wallpaper: wallpaper,
    );
  }
}
