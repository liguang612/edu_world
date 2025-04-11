import 'package:edu_world/bloc/course/course_bloc.dart';
import 'package:edu_world/config/routes.dart';
import 'package:edu_world/data/local/local_data_access.dart';
import 'package:edu_world/data/resources/colors.dart';
import 'package:edu_world/data/resources/resources.dart';
import 'package:edu_world/data/resources/theme.dart';
import 'package:edu_world/di/di.dart';
import 'package:edu_world/model/entity/course.dart';
import 'package:edu_world/shared/utils/ext/build_context_ext.dart';
import 'package:edu_world/view/course/widgets/chapter_list.dart';
import 'package:edu_world/view/course/widgets/new_chapter_input.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

class CourseDetail extends StatefulWidget {
  const CourseDetail({super.key});

  @override
  State<CourseDetail> createState() => _CourseDetailState();
}

class _CourseDetailState extends State<CourseDetail> {
  final LocalDataAccess localDataAccess = getIt.get();

  late final CourseBloc bloc;

  late final Course course;

  bool isAdding = false, isInitialized = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!isInitialized) {
      final CourseDetailArgs args = context.arguments!;
      bloc = args.bloc;
      course = args.course;

      isInitialized = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: bloc,
      child: Scaffold(
        body: SizedBox(
          height: context.screenHeight,
          width: context.screenWidth,
          child: Stack(children: [
            SvgPicture.asset(Assets.icDefaultCourseDetail, width: context.screenWidth),
            Positioned(
                left: 16,
                top: 32,
                child: IconButton(
                  icon: const Icon(Icons.arrow_back, size: 16),
                  onPressed: () => Navigator.pop(context),
                  style: IconButton.styleFrom(backgroundColor: AppColor.white, padding: const EdgeInsets.all(8)),
                )),
            Positioned(
              bottom: 0,
              child: Container(
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(60), topRight: Radius.circular(60)),
                  color: AppColor.white,
                ),
                height: context.screenHeight * 842 / 1083,
                padding: const EdgeInsets.only(left: 16, right: 16, top: 60),
                width: context.screenWidth,
                child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Text(course.name, style: AppTextTheme.interSemiBold16),
                  const SizedBox(height: 25),
                  Row(children: [
                    Text(course.subject.toString(),
                        style: AppTextTheme.interRegular12.copyWith(color: AppColor.gray03)),
                    const Spacer(),
                    Text(
                      '${course.chapters?.length ?? 0} chương',
                      style: AppTextTheme.interRegular12.copyWith(color: AppColor.gray03),
                    )
                  ]),
                  const SizedBox(height: 25),
                  const Text('Giới thiệu', style: AppTextTheme.interSemiBold14),
                  const SizedBox(height: 15),
                  Text(course.description, style: AppTextTheme.interRegular12.copyWith(color: AppColor.gray03)),
                  const SizedBox(height: 25),
                  Row(children: [
                    const Text('Danh sách các chương', style: AppTextTheme.interSemiBold14),
                    const Spacer(),
                    if (localDataAccess.getRole() == 1)
                      ElevatedButton(
                        onPressed: () => setState(() => isAdding = true),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColor.white,
                          elevation: 0,
                          minimumSize: Size.zero,
                          padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 6),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(4),
                            side: const BorderSide(color: AppColor.purple01),
                          ),
                        ),
                        child: const Text('+ Chương', style: AppTextTheme.interMedium11),
                      )
                  ]),
                  BlocBuilder<CourseBloc, CourseState>(
                    builder: (context, state) {
                      if (state is AddChapterSuccess) (course.chapters ?? []).add(state.chapter);
                      return Expanded(child: ChapterList(course.chapters ?? []));
                    },
                  ),
                  if (isAdding)
                    NewChapterInput(
                      onAccept: (p0) => bloc.add(AddChapter(course.id, p0)),
                      onCancel: () => setState(() => isAdding = false),
                    ),
                  if (localDataAccess.getRole() == 1)
                    Container(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () => Navigator.pushNamed(
                          context,
                          AppRoute.editCourse,
                          arguments: EditCourseArgs(course),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColor.purple01,
                          padding: const EdgeInsets.symmetric(vertical: 15),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
                        ),
                        child: const Text('Sửa', style: AppTextTheme.interMedium18),
                      ),
                    )
                ]),
              ),
            )
          ]),
        ),
      ),
    );
  }
}
