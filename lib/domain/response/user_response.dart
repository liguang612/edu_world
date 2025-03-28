import 'package:cloud_firestore/cloud_firestore.dart';

class UserResponse {
  final String id;
  final Timestamp birthday;
  final String district;
  final int grade;
  final String name;
  final String phone;
  final String province;
  final int role;
  final String school;

  const UserResponse(
    this.id, {
    required this.birthday,
    required this.district,
    required this.grade,
    required this.name,
    required this.phone,
    required this.province,
    required this.role,
    required this.school,
  });

  UserResponse copyWith({
    Timestamp? birthday,
    String? district,
    int? grade,
    String? name,
    String? phone,
    String? province,
    int? role,
    String? school,
  }) {
    return UserResponse(
      id,
      birthday: birthday ?? this.birthday,
      district: district ?? this.district,
      grade: grade ?? this.grade,
      name: name ?? this.name,
      phone: phone ?? this.phone,
      province: province ?? this.province,
      role: role ?? this.role,
      school: school ?? this.school,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'birthday': birthday,
      'district': district,
      'grade': grade,
      'name': name,
      'phone': phone,
      'province': province,
      'role': role,
      'school': school,
    };
  }

  factory UserResponse.fromMap(String id, Map<String, dynamic> map) {
    return UserResponse(
      id,
      birthday: map['birthday'] as Timestamp,
      district: map['district'] as String,
      grade: map['grade'] as int,
      name: map['name'] as String,
      phone: map['phone'] as String,
      province: map['province'] as String,
      role: map['role'] as int,
      school: map['school'] as String,
    );
  }

  @override
  String toString() {
    return 'UserResponse(id: $id, birthday: $birthday, district: $district, grade: $grade, name: $name, phone: $phone, province: $province, role: $role, school: $school)';
  }

  @override
  bool operator ==(covariant UserResponse other) {
    if (identical(this, other)) return true;

    return other.birthday == birthday &&
        other.district == district &&
        other.grade == grade &&
        other.name == name &&
        other.phone == phone &&
        other.province == province &&
        other.role == role &&
        other.school == school;
  }

  @override
  int get hashCode {
    return birthday.hashCode ^
        district.hashCode ^
        grade.hashCode ^
        name.hashCode ^
        phone.hashCode ^
        province.hashCode ^
        role.hashCode ^
        school.hashCode;
  }
}
