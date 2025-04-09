import 'dart:async';

import 'package:edu_world/di/di.dart';
import 'package:edu_world/usecase/get_reviews_score_usecase.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'course_state.dart';
part 'course_event.dart';

class CourseBloc extends Bloc<CourseEvent, CourseState> {
  final GetReviewsScoreUsecase _getReviewsScoreUsecase = getIt.get();

  CourseBloc() : super(const CourseState()) {
    on<GetReviews>(_onGetReviews);
  }

  FutureOr<void> _onGetReviews(GetReviews event, Emitter<CourseState> emit) async {
    final response = await _getReviewsScoreUsecase.execute(GetReviewScoreInput(event.courseId));

    emit(GetReviewsScoreAverageSuccess(response.score, response.message ?? ''));
  }
}
