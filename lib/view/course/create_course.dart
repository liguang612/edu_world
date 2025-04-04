import 'package:edu_world/data/resources/colors.dart';
import 'package:edu_world/data/resources/resources.dart';
import 'package:edu_world/data/resources/theme.dart';
import 'package:edu_world/shared/utils/ext/build_context_ext.dart';
import 'package:edu_world/shared/widgets/custom_text_field.dart';
import 'package:edu_world/shared/widgets/dropdown.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

// ignore: must_be_immutable
class CreateCourse extends StatelessWidget {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _taController = TextEditingController();
  final TextEditingController _studentController = TextEditingController();
  int _grade = 0;
  String _subjectId = '';

  CreateCourse({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(children: [
        // Header
        Stack(children: [
          SvgPicture.asset(Assets.icRect36, width: context.screenWidth),
          Positioned.fill(
              child: Center(
            child: Text(
              'Mở lớp học mới ngay hôm nay',
              style: AppTextTheme.interRegular24.copyWith(color: AppColor.white),
            ),
          )),
        ]),
        // Body
        SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(left: 20, right: 20, top: 8),
            child: Column(children: [
              ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColor.gray05.withOpacity(0.1),
                  elevation: 0,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  padding: const EdgeInsets.all(30),
                ),
                child: Center(
                  child: Column(children: [
                    SvgPicture.asset(Assets.icImage),
                    const SizedBox(height: 10),
                    Text('Hãy thêm ảnh/video để tiếp cận thêm nhiều học sinh hơn nhé',
                        style: AppTextTheme.interRegular10.copyWith(color: AppColor.gray06))
                  ]),
                ),
              ),
              const SizedBox(height: 10),
              CustomTextField(controller: _nameController, title: 'Tên lớp học'),
              const SizedBox(height: 10),
              Row(mainAxisSize: MainAxisSize.min, children: [
                Expanded(
                  flex: 93,
                  child: Dropdown(
                    items: const [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12],
                    label: 'Khối',
                    labelStyle: AppTextTheme.interRegular12,
                    onChanged: (p0) => _grade = p0 ?? 0,
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  flex: 240,
                  child: Dropdown(
                    items: const ["Sinh học"],
                    label: 'Môn học',
                    labelStyle: AppTextTheme.interRegular12,
                    onChanged: (p0) => _subjectId = p0 ?? '',
                  ),
                )
              ]),
              const SizedBox(height: 10),
              CustomTextField(controller: _taController, title: 'Cộng tác viên (Trợ giảng)'),
              const SizedBox(height: 10),
              CustomTextField(controller: _studentController, title: 'Học sinh'),
              Wrap(
                spacing: 8.0,
                children: ['_tags'].map((tag) {
                  return Chip(
                    label: Text(tag),
                    deleteIcon: Icon(Icons.close),
                    onDeleted: () => print('removed'),
                  );
                }).toList(),
              ),
            ]),
          ),
        )
      ]),
    );
  }
}
