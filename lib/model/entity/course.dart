import 'package:edu_world/model/entity/chapter.dart';

class Course {
  final List<String>? allCategories;
  final List<Chapter>? chapters;
  final String description;
  final String name;
  final List<String>? studentIds;
  final String subjectId;
  final List<String> tAIds;
  final String teacherId;
  final bool visible;
  final String? wallpaper;

  Course({
    this.allCategories,
    this.chapters,
    required this.description,
    required this.name,
    this.studentIds,
    required this.subjectId,
    required this.tAIds,
    required this.teacherId,
    required this.visible,
    this.wallpaper,
  });

  List<String> lectureIds() {
    final lectures = <String>[];

    for (var chapter in chapters ?? []) {
      lectures.addAll(chapter.lectureIds);
    }

    return lectures;
  }

  Course copyWith({
    List<String>? allCategories,
    List<Chapter>? chapters,
    String? description,
    String? name,
    List<String>? studentIds,
    String? subjectId,
    List<String>? tAIds,
    String? teacherId,
    bool? visible,
    String? wallpaper,
  }) {
    return Course(
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

  @override
  String toString() {
    return 'Course(allCategories: $allCategories, chapters: $chapters, description: $description, name: $name, studentIds: $studentIds, subjectId: $subjectId, tAIds: $tAIds, teacherId: $teacherId, visible: $visible, wallpaper: $wallpaper)';
  }
}
