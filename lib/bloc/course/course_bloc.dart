import 'dart:async';

import 'package:edu_world/di/di.dart';
import 'package:edu_world/domain/repository/course_repository.dart';
import 'package:edu_world/model/entity/chapter.dart';
import 'package:edu_world/services/lecture_service.dart';
import 'package:edu_world/usecase/get_reviews_score_usecase.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'course_state.dart';
part 'course_event.dart';

class CourseBloc extends Bloc<CourseEvent, CourseState> {
  final LectureService _lectureService = getIt.get();

  final CourseRepository _courseRepository = getIt.get();

  final GetReviewsScoreUsecase _getReviewsScoreUsecase = getIt.get();

  CourseBloc() : super(const CourseState()) {
    on<AddChapter>(_onAddChapter);
    on<GetLectures>(_onGetLectures);
    on<GetReviews>(_onGetReviews);
  }

  FutureOr<void> _onGetReviews(GetReviews event, Emitter<CourseState> emit) async {
    final response = await _getReviewsScoreUsecase.execute(GetReviewScoreInput(event.courseId));

    emit(GetReviewsScoreAverageSuccess(response.score, response.message ?? ''));
  }

  FutureOr<void> _onAddChapter(AddChapter event, Emitter<CourseState> emit) async {
    final chapter = await _courseRepository.addChapter(event.courseId, event.chapterName);

    if (chapter != null) {
      emit(AddChapterSuccess(chapter));
    } else {
      emit(AddChapterFailed());
    }
  }

  FutureOr<void> _onGetLectures(GetLectures event, Emitter<CourseState> emit) async {
    emit(GetLectureListsLoading());

    final res = await _lectureService.getLectures(event.lectureIds);

    emit(GetLectureListSuccess(res, event.chapter));
  }
}
