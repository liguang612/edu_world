import 'dart:async';

import 'package:edu_world/di/di.dart';
import 'package:edu_world/domain/repository/course_repository.dart';
import 'package:edu_world/model/entity/subject.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'create_course_state.dart';
part 'create_course_event.dart';

class CreateCourseBloc extends Bloc<CreateCourseEvent, CreateCourseState> {
  final CourseRepository _courseRepository = getIt.get();

  CreateCourseBloc() : super(const CreateCourseState()) {
    on<GetSubjects>(_onGetSubjects);
  }

  FutureOr<void> _onGetSubjects(GetSubjects event, Emitter<CreateCourseState> emit) async {
    final res = await _courseRepository.getSubjects(grade: event.grade);

    emit(GetSubjectsSuccess(res));
  }
}
