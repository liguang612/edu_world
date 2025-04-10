class Chapter {
  final List<String> lectureIds;
  final String name;

  const Chapter({
    required this.lectureIds,
    required this.name,
  });

  Chapter copyWith({
    int? id,
    List<String>? lectureIds,
    String? name,
  }) {
    return Chapter(
      lectureIds: lectureIds ?? this.lectureIds,
      name: name ?? this.name,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'lectureIds': lectureIds,
      'name': name,
    };
  }

  factory Chapter.fromMap(Map<String, dynamic> map) {
    return Chapter(
      lectureIds: List<String>.from(map['lectureIds'] as List<dynamic>),
      name: map['name'] as String,
    );
  }

  @override
  String toString() => 'Chapter(lectureIds: $lectureIds, name: $name)';
}
