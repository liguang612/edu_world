import 'package:edu_world/data/resources/colors.dart';
import 'package:edu_world/data/resources/resources.dart';
import 'package:edu_world/data/resources/theme.dart';
import 'package:edu_world/model/entity/course.dart';
import 'package:edu_world/shared/utils/ext/build_context_ext.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/svg.dart';

class CourseItem extends StatelessWidget {
  final Course course;

  const CourseItem(this.course, {super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      child: Row(children: [
        Container(
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(6)),
          width: context.screenWidth * 171 / 375,
          child: Stack(children: [
            loadWallpaper(context, course.wallpaper),
            Positioned(
              left: 10,
              top: 10,
              child: Container(
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(6), color: AppColor.white),
                padding: const EdgeInsets.symmetric(horizontal: 21, vertical: 10),
                child: const Text('Biology', style: AppTextTheme.interSemiBold10),
              ),
            ),
          ]),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(course.name, style: AppTextTheme.interSemiBold12),
            const SizedBox(height: 5),
            Row(children: [
              Expanded(
                child: Text(
                  '${course.chapters?.length ?? 0} chapters',
                  style: AppTextTheme.interRegular10.copyWith(color: AppColor.gray03),
                ),
              ),
              SvgPicture.asset(Assets.icLecture),
              const SizedBox(width: 2),
              Expanded(
                child: Text(
                  '${course.lectureIds().length} lectures',
                  style: AppTextTheme.interRegular10.copyWith(color: AppColor.gray03),
                ),
              )
            ]),
            const SizedBox(height: 12),
            Row(children: [
              SvgPicture.asset(Assets.icStudents),
              const SizedBox(width: 10),
              Text('${course.studentIds?.length ?? 0} students',
                  style: AppTextTheme.interRegular10.copyWith(color: AppColor.gray03))
            ]),
            const SizedBox(height: 12),
            Row(children: [
              RatingBarIndicator(
                rating: 3.87,
                itemBuilder: (context, index) => const Icon(Icons.star, color: Colors.amber),
                itemCount: 5,
                itemSize: 30.0,
                direction: Axis.horizontal,
              ),
              const SizedBox(width: 10),
              const Text('(3.87)', style: AppTextTheme.interRegular10)
            ]),
            const SizedBox(height: 16),
            Row(children: [
              ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColor.white01,
                  elevation: 0,
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(bottomLeft: Radius.circular(6), topLeft: Radius.circular(6)),
                    side: BorderSide(color: AppColor.gray08),
                  ),
                ),
                child: const Text('Thảo luận', style: AppTextTheme.interRegular12),
              ),
              ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColor.white01,
                  elevation: 0,
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(bottomRight: Radius.circular(6), topRight: Radius.circular(6)),
                    side: BorderSide(color: AppColor.gray08),
                  ),
                ),
                child: const Text('Đánh giá', style: AppTextTheme.interRegular12),
              ),
            ])
          ]),
        )
      ]),
    );
  }

  Widget loadWallpaper(BuildContext context, String? wallpaper) {
    try {
      Image.network(wallpaper ?? '');
    } catch (_) {}
    return SvgPicture.asset(
      Assets.icDefaultCourseWallpaper,
      width: context.screenWidth * 171 / 375,
    );
  }
}
