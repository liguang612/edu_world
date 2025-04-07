import 'dart:io';

import 'package:edu_world/di/di.dart';
import 'package:edu_world/model/entity/course.dart';
import 'package:edu_world/model/mapper/course_mapper.dart';
import 'package:edu_world/services/course_service.dart';
import 'package:edu_world/services/storage_service.dart';
import 'package:edu_world/usecase/base/base_output.dart';

class CreateCourseUsecase {
  final CourseService _courseService = getIt.get();
  final StorageService _storageService = getIt.get();

  CreateCourseUsecase();

  Future<CreateCourseOutput> execute(CreateCourseInput input) async {
    final courseId = await _courseService.createCourse(input.course.toCourseResponse());
    if (courseId == null) return const CreateCourseOutput(successful: false, message: 'Có lỗi xảy ra');

    // If no media specified, finish this usecase.
    if (input.course.wallpaper == null) return const CreateCourseOutput(successful: true);

    final wallpaperURL = await _storageService.uploadFile(File(input.course.wallpaper!), 'course/wallpaper/$courseId');
    if (wallpaperURL != null) {
      final res = await _courseService.updateCourse(courseId, wallpaper: wallpaperURL);
      if (res) return const CreateCourseOutput(successful: true, message: 'Đã tạo lớp học thành công');
    }

    return const CreateCourseOutput(successful: true, message: 'Tạo lớp học thành công (lỗi khi upload ảnh)');
  }
}

class CreateCourseInput {
  final Course course;

  const CreateCourseInput(this.course);
}

class CreateCourseOutput extends BaseOutput {
  const CreateCourseOutput({super.successful, super.message});
}
