// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:io';

import 'package:edu_world/di/di.dart';
import 'package:edu_world/services/course_service.dart';
import 'package:edu_world/usecase/base/base_output.dart';

class EditCourseUsecase {
  final CourseService _courseService = getIt.get();

  Future<EditCourseOutput> execute(EditCourseInput input) async {
    File? wallpaper;

    if (input.mediaPath == null) {
      wallpaper = null;
    } else {
      wallpaper = File(input.mediaPath!);
    }

    final res = await _courseService.editCourse(
      id: input.id,
      name: input.name,
      description: input.description,
      wallpaper: wallpaper,
    );

    return EditCourseOutput(
      message: res ? 'Sửa lớp học thành công' : 'Có lỗi xảy ra',
      successful: res,
    );
  }
}

class EditCourseInput {
  final String id;
  final String name;
  final String description;
  final String? mediaPath;

  EditCourseInput({
    required this.id,
    required this.name,
    required this.description,
    this.mediaPath,
  });
}

class EditCourseOutput extends BaseOutput {
  const EditCourseOutput({super.message, super.successful});
}
