import 'package:edu_world/model/entity/chapter.dart';
import 'package:edu_world/model/entity/subject.dart';

class Course {
  final String id;
  final List<String>? allCategories;
  final List<Chapter>? chapters;
  final String description;
  final String name;
  final List<String>? studentIds;
  final Subject subject;
  final List<String> tAIds;
  final String teacherId;
  final bool visible;
  final String? wallpaper;
  Course({
    required this.id,
    this.allCategories,
    this.chapters,
    required this.description,
    required this.name,
    this.studentIds,
    required this.subject,
    required this.tAIds,
    required this.teacherId,
    required this.visible,
    this.wallpaper,
  });

  List<int> lectureIds() {
    final List<int> res = [];
    for (Chapter chapter in chapters ?? []) {
      res.add(chapter.id);
    }

    return res;
  }

  Course copyWith({
    String? id,
    List<String>? allCategories,
    List<Chapter>? chapters,
    String? description,
    String? name,
    List<String>? studentIds,
    Subject? subject,
    List<String>? tAIds,
    String? teacherId,
    bool? visible,
    String? wallpaper,
  }) {
    return Course(
      id: id ?? this.id,
      allCategories: allCategories ?? this.allCategories,
      chapters: chapters ?? this.chapters,
      description: description ?? this.description,
      name: name ?? this.name,
      studentIds: studentIds ?? this.studentIds,
      subject: subject ?? this.subject,
      tAIds: tAIds ?? this.tAIds,
      teacherId: teacherId ?? this.teacherId,
      visible: visible ?? this.visible,
      wallpaper: wallpaper ?? this.wallpaper,
    );
  }
}
