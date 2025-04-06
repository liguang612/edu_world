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
