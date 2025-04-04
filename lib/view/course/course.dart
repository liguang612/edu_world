import 'package:edu_world/config/routes.dart';
import 'package:edu_world/data/resources/colors.dart';
import 'package:edu_world/data/resources/resources.dart';
import 'package:edu_world/data/resources/theme.dart';
import 'package:edu_world/shared/utils/ext/build_context_ext.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class Course extends StatelessWidget {
  const Course({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: [
        Center(
            child: Column(mainAxisSize: MainAxisSize.min, children: [
          SvgPicture.asset(Assets.icEmptyCourse),
          const SizedBox(height: 18),
          Text(
            'Bạn chưa tạo lớp học nào',
            style: AppTextTheme.interRegular20.copyWith(color: AppColor.black.withOpacity(0.3)),
          ),
        ])),
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
    );
  }

  void _onCreateCourse(BuildContext context) {
    Navigator.pushNamed(context, AppRoute.createCourse);
  }
}
