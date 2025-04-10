import 'dart:io';

import 'package:edu_world/bloc/course/create/create_course_bloc.dart';
import 'package:edu_world/data/resources/colors.dart';
import 'package:edu_world/data/resources/resources.dart';
import 'package:edu_world/data/resources/theme.dart';
import 'package:edu_world/di/di.dart';
import 'package:edu_world/model/entity/subject.dart';
import 'package:edu_world/shared/utils/ext/build_context_ext.dart';
import 'package:edu_world/shared/utils/ext/string_ext.dart';
import 'package:edu_world/shared/widgets/custom_chip.dart';
import 'package:edu_world/shared/widgets/custom_text_field.dart';
import 'package:edu_world/shared/widgets/dropdown.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';

// ignore: must_be_immutable
class CreateCourse extends StatefulWidget {
  const CreateCourse({super.key});

  @override
  State<CreateCourse> createState() => _CreateCourseState();
}

class _CreateCourseState extends State<CreateCourse> {
  final CreateCourseBloc bloc = getIt.get();

  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _taController = TextEditingController();
  final TextEditingController _studentController = TextEditingController();
  String? _mediaPath;
  String _subjectId = '';
  List<String> tAs = [], students = [];

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: bloc,
      child: Scaffold(
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
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.only(left: 20, right: 20, top: 8),
                child: Column(children: [
                  ElevatedButton(
                    onPressed: _onSelectWallpaper,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColor.gray05.withOpacity(0.1),
                      elevation: 0,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                      padding: _mediaPath == null ? const EdgeInsets.all(30) : EdgeInsets.zero,
                    ),
                    child: _mediaPath == null
                        ? Center(
                            child: Column(children: [
                              SvgPicture.asset(Assets.icImage),
                              const SizedBox(height: 10),
                              Text('Hãy thêm ảnh/video để tiếp cận thêm nhiều học sinh hơn nhé',
                                  style: AppTextTheme.interRegular10.copyWith(color: AppColor.gray06))
                            ]),
                          )
                        : Image.file(File(_mediaPath!)),
                  ),
                  const SizedBox(height: 10),
                  CustomTextField(controller: _nameController, title: 'Tên lớp học'),
                  const SizedBox(height: 10),
                  CustomTextField(controller: _descriptionController, maxLines: null, title: 'Thêm 1 chút mô tả'),
                  const SizedBox(height: 10),
                  Row(mainAxisSize: MainAxisSize.min, children: [
                    Expanded(
                      flex: 93,
                      child: Dropdown(
                        items: const [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12],
                        label: 'Khối',
                        labelStyle: AppTextTheme.interRegular12,
                        onChanged: (p0) => bloc.add(GetSubjects(p0)),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      flex: 240,
                      child: BlocBuilder<CreateCourseBloc, CreateCourseState>(
                        buildWhen: (previous, current) => current is GetSubjectsSuccess,
                        builder: (context, state) {
                          return Dropdown(
                            items: state is GetSubjectsSuccess ? state.subjects : [],
                            label: 'Môn học',
                            labelStyle: AppTextTheme.interRegular12,
                            onChanged: (p0) => _subjectId = (p0 as Subject).id,
                          );
                        },
                      ),
                    )
                  ]),
                  const SizedBox(height: 10),
                  CustomTextField(
                    controller: _taController,
                    onSubmitted: (p0) => _appendUserEmail(p0, true),
                    title: 'Cộng tác viên (Trợ giảng)',
                  ),
                  SizedBox(
                    width: context.screenWidth,
                    child: Wrap(
                        children: tAs
                            .map((e) => CustomChip(
                                  onDeleted: (tag) => setState(() => tAs.remove(tag)),
                                  tag: e,
                                ))
                            .toList()),
                  ),
                  const SizedBox(height: 10),
                  CustomTextField(
                    controller: _studentController,
                    onSubmitted: (p0) => _appendUserEmail(p0, false),
                    title: 'Học sinh',
                  ),
                  SizedBox(
                    width: context.screenWidth,
                    child: Wrap(
                        children: students
                            .map((e) => CustomChip(
                                  onDeleted: (tag) => setState(() => students.remove(tag)),
                                  tag: e,
                                ))
                            .toList()),
                  ),
                  const SizedBox(height: 10),
                  BlocListener<CreateCourseBloc, CreateCourseState>(
                    listener: (context, state) {
                      if (state is CreateCourseSuccess) {
                        Fluttertoast.showToast(msg: state.message ?? '');
                        Navigator.pop(context);
                      } else if (state is CreateCourseFailed) {
                        Fluttertoast.showToast(msg: state.message ?? '');
                      }
                    },
                    child: SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: _onCreateCourse,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColor.purple01,
                          padding: const EdgeInsets.symmetric(vertical: 15),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
                        ),
                        child: const Text('Tạo lớp học', style: AppTextTheme.interMedium14),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                ]),
              ),
            ),
          )
        ]),
      ),
    );
  }

  void _appendUserEmail(String text, bool isTA) {
    setState(() {
      if (isTA) {
        tAs.addAll(text.extractEmails());
        _taController.clear();
      } else {
        students.addAll(text.extractEmails());
        _studentController.clear();
      }
    });
  }

  _onCreateCourse() async {
    bloc.add(CreateNewCourse(
      description: _descriptionController.text,
      mediaPath: _mediaPath,
      name: _nameController.text,
      subjectId: _subjectId,
      studentIds: students,
      tAIds: tAs,
    ));
  }

  Future<void> _onSelectWallpaper() async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles();

      if (result != null) {
        setState(() => _mediaPath = result.files.single.path);
        return;
      }

      Fluttertoast.showToast(msg: 'Đã huỷ');
    } catch (e) {
      print(e);
      Fluttertoast.showToast(msg: 'Có lỗi xảy ra');
    }
  }
}
