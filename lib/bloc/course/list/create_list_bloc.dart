import 'dart:async';

import 'package:edu_world/di/di.dart';
import 'package:edu_world/model/entity/course.dart';
import 'package:edu_world/usecase/get_courses_usecase.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'create_list_state.dart';
part 'create_list_event.dart';

class CreateListBloc extends Bloc<CreateListEvent, CreateListState> {
  final GetCoursesUsecase _getCoursesUsecase = getIt.get();

  CreateListBloc() : super(const CreateListState()) {
    on<GetCourses>(_onGetCourses);
  }

  FutureOr<void> _onGetCourses(GetCourses event, Emitter<CreateListState> emit) async {
    final output = await _getCoursesUsecase.execute();

    if (output.successful == true) {
      emit(GetCoursesSuccess(output.courses));
    } else {
      emit(GetCoursesFailed(output.message ?? 'Lỗi không xác định'));
    }
  }
}
