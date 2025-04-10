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

class GetLectures extends CourseEvent {
  final List<String> lectureIds;
  final Chapter chapter;

  const GetLectures(this.lectureIds, this.chapter);

  @override
  List<Object?> get props => [lectureIds, chapter];
}

class EditCourseEvent extends CourseEvent {
  final String id;
  final String description;
  final String? mediaPath;
  final String name;

  const EditCourseEvent({
    required this.id,
    required this.description,
    this.mediaPath,
    required this.name,
  });

  @override
  List<Object?> get props => [id, description, name, mediaPath];
}
