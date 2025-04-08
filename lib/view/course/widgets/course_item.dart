import 'package:edu_world/data/resources/colors.dart';
import 'package:edu_world/data/resources/resources.dart';
import 'package:edu_world/data/resources/theme.dart';
import 'package:edu_world/model/entity/course.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class CourseItem extends StatelessWidget {
  final Course course;

  const CourseItem(this.course, {super.key});

  @override
  Widget build(BuildContext context) {
    return Row(children: [
      Container(
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(6)),
        child: Stack(children: [
          course.wallpaper != null
              ? Image.network(course.wallpaper!)
              : SvgPicture.asset(Assets.icDefaultCourseWallpaper),
          Container(
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(6), color: AppColor.white),
            child: const Text(
              'Biology',
              style: TextStyle(color: AppColor.purple01),
            ),
          ),
        ]),
      ),
      const SizedBox(width: 10),
      Column(children: [
        Text(course.name),
        Row(children: [
          Text(
            '${course.chapters?.length ?? 0} chapters',
            style: AppTextTheme.interRegular10.copyWith(color: AppColor.gray03),
          ),
          const Spacer(),
          SvgPicture.asset(Assets.icLecture),
          const SizedBox(width: 2),
          Text(
            '${course.lectureIds().length} lectures',
            style: AppTextTheme.interRegular10.copyWith(color: AppColor.gray03),
          )
        ])
      ])
    ]);
  }
}
