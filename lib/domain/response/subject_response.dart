class SubjectResponse {
  final String id;
  final String name;
  final int grade;
  SubjectResponse({
    required this.id,
    required this.name,
    required this.grade,
  });

  SubjectResponse copyWith({
    String? id,
    String? name,
    int? grade,
  }) {
    return SubjectResponse(
      id: id ?? this.id,
      name: name ?? this.name,
      grade: grade ?? this.grade,
    );
  }

  factory SubjectResponse.fromMap(String id, Map<String, dynamic> map) {
    return SubjectResponse(
      id: id,
      name: map['name'] as String,
      grade: map['grade'] as int,
    );
  }

  @override
  String toString() => 'SubjectResponse(id: $id, name: $name, grade: $grade)';
}
