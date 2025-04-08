part of 'course_list_bloc.dart';

class CourseListState extends Equatable {
  const CourseListState();

  @override
  List<Object?> get props => [];
}

class GetCoursesSuccess extends CourseListState {
  final List<Course> courses;

  const GetCoursesSuccess(this.courses);

  @override
  List<Object?> get props => [courses];
}

class GetCoursesFailed extends CourseListState {
  final String message;

  const GetCoursesFailed(this.message);

  @override
  List<Object?> get props => [message];
}
