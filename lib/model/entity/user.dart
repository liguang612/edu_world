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
  String? avatarUrl;
  String? email;

  User(
    this.id, {
    required this.birthday,
    required this.district,
    required this.grade,
    required this.name,
    required this.phone,
    required this.province,
    required this.role,
    required this.school,
    this.avatarUrl,
    this.email,
  });

  String address() {
    String address = '';

    String district = this.district.toLowerCase(), province = this.province.toLowerCase();
    if (!district.contains('huyện') && !district.contains('quận')) address += 'Huyện ';
    address += '${this.district}, ';
    if (!province.contains('tỉnh') && !province.contains('tp')) address += 'tỉnh ';
    address += this.province;

    return address;
  }
}
