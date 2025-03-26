import 'package:edu_world/bloc/register/register_bloc.dart';
import 'package:edu_world/data/resources/colors.dart';
import 'package:edu_world/data/resources/resources.dart';
import 'package:edu_world/data/resources/theme.dart';
import 'package:edu_world/di/di.dart';
import 'package:edu_world/shared/utils/ext/build_context_ext.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

class Register extends StatelessWidget {
  final RegisterBloc bloc = getIt.get();

  final TextEditingController birthController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();

  Register({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.backgroundColor,
      body: BlocListener<RegisterBloc, RegisterState>(
        bloc: bloc,
        listener: (context, state) {},
        child: Column(children: [
          SizedBox(
            height: context.screenHeight * (1 - 483 / 812),
            child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                SvgPicture.asset(Assets.icLogo),
                const SizedBox(width: 16),
                const Text('EDU\nWORLD', style: AppTextTheme.lilitaOneRegular24)
              ]),
              const SizedBox(height: 72),
              const Text(
                'Chào Ragnie,\nHãy mô tả thêm về bản thân nhé!',
                style: AppTextTheme.interRegular24,
                textAlign: TextAlign.center,
              )
            ]),
          ),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(topLeft: Radius.circular(40), topRight: Radius.circular(40)),
                boxShadow: [
                  BoxShadow(blurRadius: 50, color: AppColor.black.withOpacity(0.09), offset: const Offset(0, -4))
                ],
                color: AppColor.white,
              ),
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 56),
              width: context.screenWidth,
              child: SingleChildScrollView(
                child: Column(crossAxisAlignment: CrossAxisAlignment.start, mainAxisSize: MainAxisSize.min, children: [
                  const Text('Đăng ký', style: AppTextTheme.interRegular18),
                  const SizedBox(height: 24),
                  TextField(
                    controller: nameController,
                    decoration: const InputDecoration(
                      contentPadding: EdgeInsets.symmetric(horizontal: 8, vertical: 10),
                      hintStyle: AppTextTheme.interRegular14,
                      hintText: 'Họ và tên',
                      isDense: true,
                    ),
                  ),
                  const SizedBox(height: 24),
                  TextField(
                    controller: birthController,
                    decoration: const InputDecoration(
                      contentPadding: EdgeInsets.symmetric(horizontal: 8, vertical: 10),
                      hintStyle: AppTextTheme.interRegular14,
                      hintText: 'Ngày sinh',
                      isDense: true,
                    ),
                  ),
                  const SizedBox(height: 24),
                  TextField(
                    controller: phoneController,
                    decoration: const InputDecoration(
                      contentPadding: EdgeInsets.symmetric(horizontal: 8, vertical: 10),
                      hintStyle: AppTextTheme.interRegular14,
                      hintText: 'Số điện thoại',
                      isDense: true,
                    ),
                  ),
                  DropdownButtonFormField<String>(
                    decoration: const InputDecoration(
                      contentPadding: EdgeInsets.symmetric(horizontal: 8, vertical: 10),
                      hintStyle: AppTextTheme.interRegular14,
                      hintText: 'Chọn lớp',
                      isDense: true,
                    ),
                    value: 'Lớp 1',
                    items: ['Lớp 1', 'Lớp 2', 'Lớp 3', 'Lớp 4', 'Lớp 5']
                        .map((grade) => DropdownMenuItem<String>(
                              value: grade,
                              child: Text(grade),
                            ))
                        .toList(),
                    onChanged: (value) {
                      // setState(() {
                      //   selectedGrade = value;
                      // });
                    },
                  ),
                  DropdownButtonFormField<String>(
                    decoration: const InputDecoration(
                      contentPadding: EdgeInsets.symmetric(horizontal: 8, vertical: 10),
                      hintStyle: AppTextTheme.interRegular14,
                      hintText: 'Chọn lớp',
                      isDense: true,
                    ),
                    value: 'Lớp 1',
                    items: ['Lớp 1', 'Lớp 2', 'Lớp 3', 'Lớp 4', 'Lớp 5']
                        .map((grade) => DropdownMenuItem<String>(
                              value: grade,
                              child: Text(grade),
                            ))
                        .toList(),
                    onChanged: (value) {
                      // setState(() {
                      //   selectedGrade = value;
                      // });
                    },
                  ),
                  DropdownButtonFormField<String>(
                    decoration: const InputDecoration(
                      contentPadding: EdgeInsets.symmetric(horizontal: 8, vertical: 10),
                      hintStyle: AppTextTheme.interRegular14,
                      hintText: 'Chọn lớp',
                      isDense: true,
                    ),
                    value: null,
                    items: ['Lớp 1', 'Lớp 2', 'Lớp 3', 'Lớp 4', 'Lớp 5']
                        .map((grade) => DropdownMenuItem<String>(
                              value: grade,
                              child: Text(grade),
                            ))
                        .toList(),
                    onChanged: (value) {
                      // setState(() {
                      //   selectedGrade = value;
                      // });
                    },
                  ),
                ]),
              ),
            ),
          )
        ]),
      ),
    );
  }
}
