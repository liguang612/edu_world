import 'package:edu_world/data/resources/colors.dart';
import 'package:edu_world/data/resources/resources.dart';
import 'package:edu_world/data/resources/theme.dart';
import 'package:edu_world/view/account/account.dart';
import 'package:edu_world/view/course/course.dart';
import 'package:edu_world/view/dashboard/dashboard.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int currentTab = 0;

  List<Widget> tabs = [
    const Dashboard(),
    Course(),
    Account(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: tabs[currentTab],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentTab,
        items: [
          BottomNavigationBarItem(
            icon: Padding(
              padding: const EdgeInsets.only(top: 20),
              child: Row(mainAxisAlignment: MainAxisAlignment.center, mainAxisSize: MainAxisSize.min, children: [
                SvgPicture.asset(
                  Assets.icHome,
                  colorFilter: ColorFilter.mode(
                    currentTab == 0 ? AppColor.purple01 : AppColor.gray02,
                    BlendMode.srcIn,
                  ),
                ),
                const SizedBox(width: 8),
                Text(
                  'Trang chủ',
                  style:
                      AppTextTheme.interMedium14.copyWith(color: currentTab == 0 ? AppColor.purple01 : AppColor.gray03),
                ),
              ]),
            ),
            label: '', // Empty label since we include it in the icon widget
          ),
          BottomNavigationBarItem(
            icon: Padding(
              padding: const EdgeInsets.only(top: 20),
              child: Row(mainAxisAlignment: MainAxisAlignment.center, mainAxisSize: MainAxisSize.min, children: [
                SvgPicture.asset(
                  Assets.icCourse,
                  colorFilter: ColorFilter.mode(
                    currentTab == 1 ? AppColor.purple01 : AppColor.gray02,
                    BlendMode.srcIn,
                  ),
                ),
                const SizedBox(width: 8),
                Text(
                  'Khoá học',
                  style:
                      AppTextTheme.interMedium14.copyWith(color: currentTab == 1 ? AppColor.purple01 : AppColor.gray03),
                ),
              ]),
            ),
            label: '', // Empty label since we include it in the icon widget
          ),
          BottomNavigationBarItem(
            icon: Padding(
              padding: const EdgeInsets.only(top: 20),
              child: Row(mainAxisAlignment: MainAxisAlignment.center, mainAxisSize: MainAxisSize.min, children: [
                SvgPicture.asset(
                  Assets.icAccount,
                  colorFilter: ColorFilter.mode(
                    currentTab == 2 ? AppColor.purple01 : AppColor.gray02,
                    BlendMode.srcIn,
                  ),
                ),
                const SizedBox(width: 8),
                Text(
                  'Tài khoản',
                  style:
                      AppTextTheme.interMedium14.copyWith(color: currentTab == 2 ? AppColor.purple01 : AppColor.gray03),
                ),
              ]),
            ),
            label: '', // Empty label since we include it in the icon widget
          ),
        ],
        onTap: (value) => setState(() => currentTab = value),
      ),
    );
  }
}
