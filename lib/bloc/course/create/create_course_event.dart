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
