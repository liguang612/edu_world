import 'package:edu_world/bloc/course/list/course_list_bloc.dart';
import 'package:edu_world/config/routes.dart';
import 'package:edu_world/data/resources/colors.dart';
import 'package:edu_world/data/resources/resources.dart';
import 'package:edu_world/data/resources/theme.dart';
import 'package:edu_world/di/di.dart';
import 'package:edu_world/shared/utils/ext/build_context_ext.dart';
import 'package:edu_world/view/course/widgets/course_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

class Course extends StatelessWidget {
  final CourseListBloc bloc = getIt.get();

  Course({super.key}) {
    bloc.add(const GetCourses());
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: bloc,
      child: Scaffold(
        backgroundColor: AppColor.white01,
        body: Stack(children: [
          RefreshIndicator.adaptive(
            onRefresh: () async {
              bloc.add(const GetCourses());
            },
            child: BlocBuilder<CourseListBloc, CourseListState>(
              builder: (context, state) {
                if (state is GetCoursesSuccess && state.courses.isNotEmpty) {
                  return ListView.builder(
                    itemBuilder: (context, index) => CourseItem(state.courses[index]),
                    itemCount: state.courses.length,
                  );
                }
                return ListView(children: [
                  SizedBox(height: context.screenHeight * 0.3),
                  Center(
                    child: Column(mainAxisSize: MainAxisSize.min, children: [
                      SvgPicture.asset(Assets.icEmptyCourse),
                      const SizedBox(height: 18),
                      Text(
                        'Bạn chưa tạo lớp học nào',
                        style: AppTextTheme.interRegular20.copyWith(
                          color: AppColor.black.withOpacity(0.3),
                        ),
                      ),
                    ]),
                  ),
                ]);
              },
            ),
          ),
          Positioned(
            bottom: 12,
            child: SizedBox(
              width: context.screenWidth,
              child: Row(children: [
                const Spacer(),
                ElevatedButton(
                  onPressed: () => _onCreateCourse(context),
                  style: ElevatedButton.styleFrom(backgroundColor: AppColor.purple01),
                  child: const Row(children: [
                    Icon(Icons.add, color: AppColor.white, size: 18),
                    SizedBox(width: 8),
                    Text('Tạo lớp học', style: AppTextTheme.interMedium14),
                  ]),
                ),
                const Spacer(),
              ]),
            ),
          )
        ]),
      ),
    );
  }

  void _onCreateCourse(BuildContext context) {
    Navigator.pushNamed(context, AppRoute.createCourse);
  }
}
