import 'dart:async';

import 'package:edu_world/di/di.dart';
import 'package:edu_world/domain/repository/register_repository.dart';
import 'package:edu_world/usecase/get_classes_usecase.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'register_state.dart';
part 'register_event.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  final RegisterRepository _registerRepository = getIt.get();

  final GetClassesUsecase _getClassesUsecase = getIt.get();

  RegisterBloc() : super(const RegisterState()) {
    on<GetDistricts>(_onGetDistricts);
    on<GetProvince>(_onGetProvinces);
    on<GetSchools>(_onGetSchools);
    on<GetClasses>(_onGetClasses);
    on<RegisterSubmit>(_onRegister);
  }

  FutureOr<void> _onRegister(RegisterSubmit event, Emitter<RegisterState> emit) async {}

  FutureOr<void> _onGetProvinces(GetProvince event, Emitter<RegisterState> emit) async {
    final provinces = await _registerRepository.getProvinces();

    emit(GetProvincesSuccess(provinces));
  }

  FutureOr<void> _onGetDistricts(GetDistricts event, Emitter<RegisterState> emit) async {
    final districts = await _registerRepository.getDistricts(event.province);

    emit(GetDistrictsSuccess(districts));
  }

  FutureOr<void> _onGetSchools(GetSchools event, Emitter<RegisterState> emit) async {
    final schools = await _registerRepository.getSchools(event.district);

    emit(GetSchoolsSuccess(schools));
  }

  _onGetClasses(GetClasses event, Emitter<RegisterState> emit) {
    final output = _getClassesUsecase.execute(GetClassesInput(event.school));

    emit(GetClassesSuccess(output.classes));
  }
}
