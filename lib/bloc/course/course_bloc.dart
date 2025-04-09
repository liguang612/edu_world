import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'course_state.dart';
part 'course_event.dart';

class CourseBloc extends Bloc<CourseEvent, CourseState> {
  CourseBloc() : super(const CourseState()) {
    on<GetReviews>(_onGetReviews);
  }

  FutureOr<void> _onGetReviews(GetReviews event, Emitter<CourseState> emit) async {}
}
