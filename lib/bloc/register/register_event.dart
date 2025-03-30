part of 'register_bloc.dart';

class RegisterEvent extends Equatable {
  const RegisterEvent();

  @override
  List<Object?> get props => [];
}

class GetProvince extends RegisterEvent {}

class GetDistricts extends RegisterEvent {
  final String province;

  const GetDistricts(this.province);
  @override
  List<Object?> get props => [province];
}

class GetSchools extends RegisterEvent {
  final String district;

  const GetSchools(this.district);
  @override
  List<Object?> get props => [district];
}

class GetClasses extends RegisterEvent {
  final String school;

  const GetClasses(this.school);
  @override
  List<Object?> get props => [school];
}

class RegisterSubmit extends RegisterEvent {
  final String name;
  final DateTime? birth;
  final String phone;
  final String? province;
  final String? district;
  final int? role;
  final String? school;
  final int Class;

  const RegisterSubmit({
    required this.name,
    this.birth,
    required this.phone,
    this.province,
    this.district,
    this.role,
    this.school,
    required this.Class,
  });

  @override
  List<Object?> get props => [name, birth, phone, province, district, role, school, Class];
}
