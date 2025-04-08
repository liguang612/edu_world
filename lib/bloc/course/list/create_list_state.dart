part of 'create_list_bloc.dart';

class CreateListState extends Equatable {
  const CreateListState();

  @override
  List<Object?> get props => [];
}

class GetCoursesSuccess extends CreateListState {
  final List<Course> courses;

  const GetCoursesSuccess(this.courses);

  @override
  List<Object?> get props => [courses];
}

class GetCoursesFailed extends CreateListState {
  final String message;

  const GetCoursesFailed(this.message);

  @override
  List<Object?> get props => [message];
}
