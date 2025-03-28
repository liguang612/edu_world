part of 'register_bloc.dart';

class RegisterState extends Equatable {
  const RegisterState();

  @override
  List<Object?> get props => [];
}

class GetProvincesSuccess extends RegisterState {
  final List<String> provinces;

  const GetProvincesSuccess(this.provinces);
  @override
  List<Object?> get props => [provinces];
}

class GetProvincesFailed extends RegisterState {}

class GetDistrictsSuccess extends RegisterState {
  final List<String> districts;

  const GetDistrictsSuccess(this.districts);
  @override
  List<Object?> get props => [districts];
}

class GetDistrictsFailed extends RegisterState {}

class GetSchoolsSuccess extends RegisterState {
  final List<String> schools;

  const GetSchoolsSuccess(this.schools);
  @override
  List<Object?> get props => [schools];
}

class GetSchoolsFailed extends RegisterState {}

class GetClassesSuccess extends RegisterState {
  final List<int> classes;

  const GetClassesSuccess(this.classes);
  @override
  List<Object?> get props => [classes];
}

class GetClassesFailed extends RegisterState {}

class RegisterUserSuccess extends RegisterState {
  final User user;

  const RegisterUserSuccess(this.user);
  @override
  List<Object?> get props => [user];
}

class RegisterUserFailed extends RegisterState {
  final String message;

  const RegisterUserFailed(this.message);
  @override
  List<Object?> get props => [message];
}
