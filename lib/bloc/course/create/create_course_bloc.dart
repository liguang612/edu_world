import 'dart:async';

import 'package:edu_world/data/local/local_data_access.dart';
import 'package:edu_world/di/di.dart';
import 'package:edu_world/domain/repository/course_repository.dart';
import 'package:edu_world/domain/response/course_response.dart';
import 'package:edu_world/model/entity/subject.dart';
import 'package:edu_world/usecase/create_course_usecase.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'create_course_state.dart';
part 'create_course_event.dart';

class CreateCourseBloc extends Bloc<CreateCourseEvent, CreateCourseState> {
  final CourseRepository _courseRepository = getIt.get();

  final CreateCourseUsecase _createCourseUsecase = getIt.get();

  final LocalDataAccess _localDataAccess = getIt.get();

  CreateCourseBloc() : super(const CreateCourseState()) {
    on<GetSubjects>(_onGetSubjects);

    on<CreateNewCourse>(_onCreateNewCourse);
  }

  FutureOr<void> _onGetSubjects(GetSubjects event, Emitter<CreateCourseState> emit) async {
    final res = await _courseRepository.getSubjects(grade: event.grade);

    emit(GetSubjectsSuccess(res));
  }

  FutureOr<void> _onCreateNewCourse(CreateNewCourse event, Emitter<CreateCourseState> emit) async {
    final output = await _createCourseUsecase.execute(CreateCourseInput(CourseResponse(
      id: '',
      description: event.description,
      name: event.name,
      subjectId: event.subjectId,
      tAIds: event.tAIds,
      teacherId: _localDataAccess.getUserId() ?? '',
      visible: true,
      wallpaper: event.mediaPath,
    )));

    if (output.successful == true) {
      emit(CreateCourseSuccess(output.message));
    } else {
      emit(CreateCourseFailed(output.message));
    }
  }
}
