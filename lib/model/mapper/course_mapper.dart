import 'package:edu_world/domain/response/course_response.dart';
import 'package:edu_world/model/entity/chapter.dart';
import 'package:edu_world/model/entity/course.dart';
import 'package:edu_world/model/entity/subject.dart';

extension CourseMapper on CourseResponse {
  Course toCourse({
    required Subject subject,
  }) {
    return Course(
      id: id,
      chapters: (chapters ?? []).map((e) => Chapter.fromMap(e)).toList(),
      description: description,
      name: name,
      subject: subject,
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
      id: id,
      chapters: (chapters ?? []).map((e) => e.toMap()).toList(),
      description: description,
      name: name,
      subjectId: subject.id,
      teacherId: teacherId,
      visible: visible,
      wallpaper: wallpaper,
    );
  }
}
