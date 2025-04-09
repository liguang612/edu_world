class CourseResponse {
  final String id;
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
    required this.id,
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
    String? id,
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
      id: id ?? this.id,
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

  factory CourseResponse.fromMap(String id, Map<String, dynamic> map) {
    return CourseResponse(
      id: id,
      allCategories: map['allCategories'] != null
          ? List.from(map['allCategories'] as List<dynamic>).map((e) => e.toString()).toList()
          : null,
      chapters: map['chapters'] != null
          ? List.from(map['chapters'] as List<dynamic>).map((e) => (e as Map<String, dynamic>)).toList()
          : null,
      description: map['description'] as String,
      name: map['name'] as String,
      studentIds:
          map['studentIds'] != null ? List.from(map['studentIds'] as List).map((e) => e.toString()).toList() : null,
      subjectId: map['subjectId'] as String,
      tAIds: map['tAIds'] != null ? List.from(map['tAIds'] as List).map((e) => e.toString()).toList() : null,
      teacherId: map['teacherId'] as String,
      visible: map['visible'] as bool,
      wallpaper: map['wallpaper'] as String,
    );
  }

  @override
  String toString() {
    return 'CourseResponse(allCategories: $allCategories, chapters: $chapters, description: $description, name: $name, studentIds: $studentIds, subjectId: $subjectId, tAIds: $tAIds, teacherId: $teacherId, visible: $visible, wallpaper: $wallpaper)';
  }
}
