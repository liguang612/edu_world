import 'dart:async';

import 'package:edu_world/di/di.dart';
import 'package:edu_world/domain/repository/register_repository.dart';
import 'package:edu_world/model/entity/user.dart';
import 'package:edu_world/usecase/get_classes_usecase.dart';
import 'package:edu_world/usecase/register_usecase.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'register_state.dart';
part 'register_event.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  final RegisterRepository _registerRepository = getIt.get();

  final GetClassesUsecase _getClassesUsecase = getIt.get();
  final RegisterUsecase _registerUsecase = getIt.get();

  RegisterBloc() : super(const RegisterState()) {
    on<GetDistricts>(_onGetDistricts);
    on<GetProvince>(_onGetProvinces);
    on<GetSchools>(_onGetSchools);
    on<GetClasses>(_onGetClasses);

    on<RegisterSubmit>(_onRegister);
  }

  FutureOr<void> _onRegister(RegisterSubmit event, Emitter<RegisterState> emit) async {
    final output = await _registerUsecase.execute(RegisterInput(
      name: event.name,
      birth: event.birth,
      phone: event.phone,
      province: event.province,
      district: event.district,
      role: event.role,
      school: event.school,
      Class: event.Class,
    ));

    if (output.successful == true) {
      emit(RegisterUserSuccess(output.user!));
    } else {
      emit(RegisterUserFailed(output.message ?? ''));
    }
  }

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
