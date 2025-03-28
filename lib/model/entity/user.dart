class User {
  final String id;
  final DateTime birthday;
  final String district;
  final int grade;
  final String name;
  final String phone;
  final String province;
  final int role;
  final String school;

  const User(
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
}
