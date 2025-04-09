part of 'course_bloc.dart';

class CourseEvent extends Equatable {
  const CourseEvent();

  @override
  List<Object?> get props => [];
}

class GetReviews extends CourseEvent {
  final String courseId;

  const GetReviews(this.courseId);

  @override
  List<Object?> get props => [courseId];
}
