import 'package:edu_world/bloc/course/course_bloc.dart';
import 'package:edu_world/config/routes.dart';
import 'package:edu_world/data/resources/colors.dart';
import 'package:edu_world/data/resources/resources.dart';
import 'package:edu_world/data/resources/theme.dart';
import 'package:edu_world/model/entity/course.dart';
import 'package:edu_world/shared/utils/ext/build_context_ext.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/svg.dart';

class CourseItem extends StatelessWidget {
  final Course course;

  final CourseBloc bloc = CourseBloc();

  CourseItem(this.course, {super.key}) {
    bloc.add(GetReviews(course.id));
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Navigator.pushNamed(
        context,
        AppRoute.detailCourse,
        arguments: CourseDetailArgs(course, bloc),
      ),
      child: Padding(
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
                  child: Text(course.subject.name, style: AppTextTheme.interSemiBold10),
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
                    '${course.chapters?.length ?? 0} chương',
                    style: AppTextTheme.interRegular10.copyWith(color: AppColor.gray03),
                  ),
                ),
                SvgPicture.asset(Assets.icLecture),
                const SizedBox(width: 2),
                Expanded(
                  child: Text(
                    '${course.lectureIds().length} bài giảng',
                    style: AppTextTheme.interRegular10.copyWith(color: AppColor.gray03),
                  ),
                )
              ]),
              const SizedBox(height: 12),
              Row(children: [
                SvgPicture.asset(Assets.icStudents),
                const SizedBox(width: 10),
                Text('${course.studentIds?.length ?? 0} học sinh',
                    style: AppTextTheme.interRegular10.copyWith(color: AppColor.gray03))
              ]),
              const SizedBox(height: 12),
              BlocBuilder<CourseBloc, CourseState>(
                bloc: bloc,
                buildWhen: (previous, current) => current is GetReviewsScoreAverageSuccess,
                builder: (context, state) {
                  return Row(children: [
                    RatingBarIndicator(
                      direction: Axis.horizontal,
                      itemBuilder: (context, index) => const Icon(Icons.star, color: Colors.amber),
                      itemCount: 5,
                      itemSize: 20,
                      rating: state is GetReviewsScoreAverageSuccess ? state.score : 0,
                    ),
                    const SizedBox(width: 10),
                    Text(
                      '(${state is GetReviewsScoreAverageSuccess ? state.scoreStr : ''})',
                      style: AppTextTheme.interRegular10,
                    )
                  ]);
                },
              ),
              const SizedBox(height: 16),
              Row(children: [
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColor.white01,
                    elevation: 0,
                    padding: const EdgeInsets.symmetric(horizontal: 12),
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
                    padding: const EdgeInsets.symmetric(horizontal: 12),
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
      ),
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
