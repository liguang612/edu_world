class Subject {
  final String id;
  final String name;
  final int grade;
  Subject({
    required this.id,
    required this.name,
    required this.grade,
  });

  Subject copyWith({
    String? id,
    String? name,
    int? grade,
  }) {
    return Subject(
      id: id ?? this.id,
      name: name ?? this.name,
      grade: grade ?? this.grade,
    );
  }

  factory Subject.fromMap(String id, Map<String, dynamic> map) {
    return Subject(
      id: id,
      name: map['name'] as String,
      grade: map['grade'] as int,
    );
  }

  @override
  String toString() => '$name lớp $grade';
}
