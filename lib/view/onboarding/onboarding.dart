import 'package:edu_world/bloc/onboarding/onboarding_bloc.dart';
import 'package:edu_world/config/routes.dart';
import 'package:edu_world/data/resources/colors.dart';
import 'package:edu_world/data/resources/resources.dart';
import 'package:edu_world/data/resources/theme.dart';
import 'package:edu_world/di/di.dart';
import 'package:edu_world/shared/utils/ext/build_context_ext.dart';
import 'package:edu_world/shared/widgets/measure_size.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

class Onboarding extends StatefulWidget {
  const Onboarding({super.key});

  @override
  State<Onboarding> createState() => _OnboardingState();
}

class _OnboardingState extends State<Onboarding> {
  final List<Map<String, String>> cards = [
    {
      'image': Assets.icOnboarding1,
      'text': 'Học & luyện thi mọi lúc & mọi nơi',
    },
    {
      'image': Assets.icOnboarding2,
      'text': 'Bải giảng được thiết kế trực quan và sinh động',
    },
    {
      'image': Assets.icOnboarding3,
      'text': 'Ôn & luyện thi trắc nghiệm với các đề thi được giáo viên thiết kế cuối mỗi bài giảng / khóa học',
    },
  ];

  final OnboardingBloc bloc = getIt.get();

  final PageController imageController = PageController();

  int pageIdx = 1;
  double? pageHeight;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(children: [
        // Use the measured height if available, otherwise render a temporary widget
        SizedBox(
          height: pageHeight ?? 0 + 50,
          child: PageView.builder(
            controller: imageController,
            itemCount: cards.length,
            itemBuilder: (context, index) => Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              SvgPicture.asset(
                cards[index]['image']!,
                width: MediaQuery.of(context).size.width,
                fit: BoxFit.contain,
              ),
              Text(
                cards[index]['text']!,
                style: AppTextTheme.interRegular20,
                textAlign: TextAlign.center,
              ),
            ]),
          ),
        ),
        Offstage(
          child: MeasureSize(
            onChange: (value) => setState(() => pageHeight = value.height),
            child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              SvgPicture.asset(cards[2]['image']!, width: MediaQuery.of(context).size.width, fit: BoxFit.contain),
              Text(cards[2]['text']!, style: AppTextTheme.interRegular20, textAlign: TextAlign.center),
            ]),
          ),
        ),

        Padding(
          padding: const EdgeInsets.only(top: 36),
          child: SizedBox(
            height: 8,
            width: context.screenWidth * 99 / 375,
            child: LinearProgressIndicator(
              backgroundColor: AppColor.purple01,
              borderRadius: BorderRadius.circular(10),
              value: pageIdx / 3,
            ),
          ),
        ),
        // Second PageView can take up remaining space
        Expanded(
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            BlocListener<OnboardingBloc, OnboardingState>(
              bloc: bloc,
              listener: (context, state) {
                if (state is OnboardingDone) Navigator.popAndPushNamed(context, AppRoute.home);
              },
              child: ElevatedButton(
                onPressed: () {
                  if (pageIdx == cards.length) {
                    bloc.add(OnboardingEvent());
                  } else {
                    imageController.nextPage(
                      duration: const Duration(milliseconds: 500),
                      curve: Curves.easeOut,
                    );
                    imageController
                        .addListener(() => setState(() => pageIdx = (imageController.page?.round() ?? 0) + 1));
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColor.purple01,
                  foregroundColor: AppColor.white,
                  padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
                ),
                child: Text(pageIdx == cards.length ? "Bắt đầu" : "Tiếp theo"),
              ),
            ),
          ]),
        ),
      ]),
    );
  }
}
