import 'package:edu_world/domain/response/subject_response.dart';
import 'package:edu_world/model/entity/subject.dart';

extension SubjectMapper on SubjectResponse {
  Subject toSubject() => Subject(id: id, name: name, grade: grade);
}
