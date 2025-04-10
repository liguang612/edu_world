import 'dart:io';

import 'package:edu_world/bloc/course/create/create_course_bloc.dart';
import 'package:edu_world/config/routes.dart';
import 'package:edu_world/data/resources/colors.dart';
import 'package:edu_world/data/resources/resources.dart';
import 'package:edu_world/data/resources/theme.dart';
import 'package:edu_world/di/di.dart';
import 'package:edu_world/shared/utils/ext/build_context_ext.dart';
import 'package:edu_world/shared/widgets/custom_text_field.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';

// ignore: must_be_immutable
class EditCourse extends StatefulWidget {
  const EditCourse({super.key});

  @override
  State<EditCourse> createState() => _EditCourseState();
}

class _EditCourseState extends State<EditCourse> {
  final CreateCourseBloc bloc = getIt.get();

  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  String? _mediaPath;

  late final EditCourseArgs args;
  bool isInitialized = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    if (!isInitialized) {
      args = context.arguments;

      _descriptionController.text = args.course.description;
      _nameController.text = args.course.name;

      isInitialized = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: bloc,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Sửa lớp học', style: AppTextTheme.interMedium14.copyWith(color: AppColor.black)),
        ),
        backgroundColor: AppColor.white01,
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(children: [
                  ElevatedButton(
                    onPressed: _onSelectWallpaper,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColor.gray05.withOpacity(0.1),
                      elevation: 0,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                      padding: _mediaPath == null ? const EdgeInsets.all(30) : EdgeInsets.zero,
                    ),
                    child: getPreview(),
                  ),
                  const SizedBox(height: 10),
                  CustomTextField(controller: _nameController, title: 'Tên lớp học'),
                  const SizedBox(height: 10),
                  CustomTextField(controller: _descriptionController, maxLines: null, title: 'Thêm 1 chút mô tả'),
                  const SizedBox(height: 10),
                ]),
              ),
            ),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColor.white,
                      elevation: 0,
                      padding: const EdgeInsets.symmetric(vertical: 15),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
                      side: const BorderSide(color: AppColor.purple01),
                    ),
                    child: Text('Chương / mục', style: AppTextTheme.interSemiBold12.copyWith(color: AppColor.purple01)),
                  ),
                ),
                const SizedBox(width: 19),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColor.white,
                      elevation: 0,
                      padding: const EdgeInsets.symmetric(vertical: 15),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
                      side: const BorderSide(color: AppColor.purple01),
                    ),
                    child: Text('Quản lý thành viên',
                        style: AppTextTheme.interSemiBold12.copyWith(color: AppColor.purple01)),
                  ),
                ),
              ],
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
                  onPressed: _onEditCourse,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColor.purple01,
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
                  ),
                  child: const Text('Lưu thay đổi', style: AppTextTheme.interMedium14),
                ),
              ),
            ),
            const SizedBox(height: 10),
          ]),
        ),
      ),
    );
  }

  _onEditCourse() async {
    bloc.add(EditCourseEvent(
      id: args.course.id,
      description: _descriptionController.text,
      mediaPath: _mediaPath,
      name: _nameController.text,
    ));
  }

  Widget getPreview() {
    if (_mediaPath != null) {
      return Image.file(File(_mediaPath!));
    } else if (args.course.wallpaper != null) {
      return Image.network(args.course.wallpaper!);
    } else {
      return Center(
        child: Column(children: [
          SvgPicture.asset(Assets.icImage),
          const SizedBox(height: 10),
          Text(
            'Hãy thêm ảnh/video để tiếp cận thêm nhiều học sinh hơn nhé',
            style: AppTextTheme.interRegular10.copyWith(color: AppColor.gray06),
          )
        ]),
      );
    }
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
