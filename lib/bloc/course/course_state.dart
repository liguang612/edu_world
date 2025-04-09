part of 'course_bloc.dart';

class CourseState extends Equatable {
  const CourseState();

  @override
  List<Object?> get props => [];
}

class GetReviewsScoreAverageSuccess extends CourseState {
  final double score;
  final String scoreStr;

  const GetReviewsScoreAverageSuccess(this.score, this.scoreStr);

  @override
  List<Object?> get props => [score, scoreStr];
}
