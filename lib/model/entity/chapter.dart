import 'package:flutter/foundation.dart';

class Chapter {
  final int id;
  final List<String> lectureIds;
  final String name;
  Chapter({
    required this.id,
    required this.lectureIds,
    required this.name,
  });

  Chapter copyWith({
    int? id,
    List<String>? lectureIds,
    String? name,
  }) {
    return Chapter(
      id: id ?? this.id,
      lectureIds: lectureIds ?? this.lectureIds,
      name: name ?? this.name,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'lectureIds': lectureIds,
      'name': name,
    };
  }

  factory Chapter.fromMap(Map<String, dynamic> map) {
    return Chapter(
      id: map['id'] as int,
      lectureIds: List<String>.from(map['lectureIds'] as List<String>),
      name: map['name'] as String,
    );
  }

  @override
  String toString() => 'Chapter(id: $id, lectureIds: $lectureIds, name: $name)';

  @override
  bool operator ==(covariant Chapter other) {
    if (identical(this, other)) return true;

    return other.id == id && listEquals(other.lectureIds, lectureIds) && other.name == name;
  }

  @override
  int get hashCode => id.hashCode ^ lectureIds.hashCode ^ name.hashCode;
}
