part of 'create_course_bloc.dart';

class CreateCourseState extends Equatable {
  const CreateCourseState();

  @override
  List<Object?> get props => [];
}

class GetSubjectsSuccess extends CreateCourseState {
  final List<Subject> subjects;

  const GetSubjectsSuccess(this.subjects);

  @override
  List<Object?> get props => [subjects];
}

class CreateCourseSuccess extends CreateCourseState {
  final String? message;

  const CreateCourseSuccess(this.message);

  @override
  List<Object?> get props => [message];
}

class CreateCourseFailed extends CreateCourseState {
  final String? message;

  const CreateCourseFailed(this.message);

  @override
  List<Object?> get props => [message];
}
