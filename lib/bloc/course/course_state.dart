part of 'course_bloc.dart';

class CourseState extends Equatable {
  const CourseState();

  @override
  List<Object?> get props => [];
}

class AddChapterSuccess extends CourseState {
  final Chapter chapter;

  const AddChapterSuccess(this.chapter);
  @override
  List<Object?> get props => [chapter];
}

class AddChapterFailed extends CourseState {}

class GetLectureListsLoading extends CourseState {}

class GetLectureListSuccess extends CourseState {
  final List<(String, String)> lectures;
  final Chapter chapter;

  const GetLectureListSuccess(this.lectures, this.chapter);

  @override
  List<Object?> get props => [lectures];
}

class GetReviewsScoreAverageSuccess extends CourseState {
  final double score;
  final String scoreStr;

  const GetReviewsScoreAverageSuccess(this.score, this.scoreStr);

  @override
  List<Object?> get props => [score, scoreStr];
}
