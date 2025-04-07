part of 'create_course_bloc.dart';

class CreateCourseEvent extends Equatable {
  const CreateCourseEvent();

  @override
  List<Object?> get props => [];
}

class GetSubjects extends CreateCourseEvent {
  final int? grade;

  const GetSubjects(this.grade);

  @override
  List<Object?> get props => [grade];
}

class CreateNewCourse extends CreateCourseEvent {
  final String description;
  final String? mediaPath;
  final String name;
  final String subjectId;
  final List<String> studentIds;
  final List<String> tAIds;

  const CreateNewCourse({
    required this.description,
    this.mediaPath,
    required this.name,
    required this.subjectId,
    required this.studentIds,
    required this.tAIds,
  });

  @override
  List<Object?> get props => [description, mediaPath, name, subjectId, studentIds, tAIds];
}
