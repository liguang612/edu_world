import 'package:flutter/foundation.dart';

class CourseResponse {
  final List<String>? allCategories;
  final List<Map<String, dynamic>>? chapters;
  final String description;
  final String name;
  final List<String>? studentIds;
  final String subjectId;
  final List<String>? tAIds;
  final String teacherId;
  final bool visible;
  final String? wallpaper;

  CourseResponse({
    this.allCategories,
    this.chapters,
    required this.description,
    required this.name,
    this.studentIds,
    required this.subjectId,
    this.tAIds,
    required this.teacherId,
    required this.visible,
    this.wallpaper,
  });

  CourseResponse copyWith({
    List<String>? allCategories,
    List<Map<String, dynamic>>? chapters,
    String? description,
    String? name,
    List<String>? studentIds,
    String? subjectId,
    List<String>? tAIds,
    String? teacherId,
    bool? visible,
    String? wallpaper,
  }) {
    return CourseResponse(
      allCategories: allCategories ?? this.allCategories,
      chapters: chapters ?? this.chapters,
      description: description ?? this.description,
      name: name ?? this.name,
      studentIds: studentIds ?? this.studentIds,
      subjectId: subjectId ?? this.subjectId,
      tAIds: tAIds ?? this.tAIds,
      teacherId: teacherId ?? this.teacherId,
      visible: visible ?? this.visible,
      wallpaper: wallpaper ?? this.wallpaper,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'allCategories': allCategories,
      'chapters': chapters,
      'description': description,
      'name': name,
      'studentIds': studentIds,
      'subjectId': subjectId,
      'tAIds': tAIds,
      'teacherId': teacherId,
      'visible': visible,
      'wallpaper': wallpaper,
    };
  }

  factory CourseResponse.fromMap(Map<String, dynamic> map) {
    return CourseResponse(
      allCategories: map['allCategories'] != null ? List<String>.from(map['allCategories'] as List<String>) : null,
      chapters: map['chapters'] != null ? map['chapters'] as List<Map<String, dynamic>> : null,
      description: map['description'] as String,
      name: map['name'] as String,
      studentIds: map['studentIds'] != null ? List<String>.from(map['studentIds'] as List<String>) : null,
      subjectId: map['subjectId'] as String,
      tAIds: List<String>.from(map['tAIds'] as List<String>),
      teacherId: map['teacherId'] as String,
      visible: map['visible'] as bool,
      wallpaper: map['wallpaper'] as String,
    );
  }

  @override
  String toString() {
    return 'CourseResponse(allCategories: $allCategories, chapters: $chapters, description: $description, name: $name, studentIds: $studentIds, subjectId: $subjectId, tAIds: $tAIds, teacherId: $teacherId, visible: $visible, wallpaper: $wallpaper)';
  }

  @override
  bool operator ==(covariant CourseResponse other) {
    if (identical(this, other)) return true;

    return listEquals(other.allCategories, allCategories) &&
        listEquals(other.chapters, chapters) &&
        other.description == description &&
        other.name == name &&
        listEquals(other.studentIds, studentIds) &&
        other.subjectId == subjectId &&
        listEquals(other.tAIds, tAIds) &&
        other.teacherId == teacherId &&
        other.visible == visible &&
        other.wallpaper == wallpaper;
  }

  @override
  int get hashCode {
    return allCategories.hashCode ^
        chapters.hashCode ^
        description.hashCode ^
        name.hashCode ^
        studentIds.hashCode ^
        subjectId.hashCode ^
        tAIds.hashCode ^
        teacherId.hashCode ^
        visible.hashCode ^
        wallpaper.hashCode;
  }
}
