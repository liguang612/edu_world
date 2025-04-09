part of 'course_bloc.dart';

class CourseEvent extends Equatable {
  const CourseEvent();

  @override
  List<Object?> get props => [];
}

class AddChapter extends CourseEvent {
  final String chapterName;
  final String courseId;

  const AddChapter(this.courseId, this.chapterName);

  @override
  List<Object?> get props => [courseId, chapterName];
}

class GetReviews extends CourseEvent {
  final String courseId;

  const GetReviews(this.courseId);

  @override
  List<Object?> get props => [courseId];
}
