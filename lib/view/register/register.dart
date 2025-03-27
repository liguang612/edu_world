import 'package:edu_world/bloc/register/register_bloc.dart';
import 'package:edu_world/data/resources/colors.dart';
import 'package:edu_world/data/resources/resources.dart';
import 'package:edu_world/data/resources/theme.dart';
import 'package:edu_world/di/di.dart';
import 'package:edu_world/shared/utils/ext/build_context_ext.dart';
import 'package:edu_world/shared/widgets/dropdown.dart';
import 'package:edu_world/shared/widgets/radio_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

class Register extends StatefulWidget {
  Register({super.key}) {}

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final RegisterBloc bloc = getIt.get();

  final TextEditingController birthController = TextEditingController();

  final TextEditingController nameController = TextEditingController();

  final TextEditingController phoneController = TextEditingController();

  String? province, district, school;

  int _class = 0;

  @override
  void initState() {
    super.initState();
    bloc.add(GetProvince());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.backgroundColor,
      body: BlocProvider.value(
        value: bloc,
        child: BlocListener<RegisterBloc, RegisterState>(
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
                  child:
                      Column(crossAxisAlignment: CrossAxisAlignment.start, mainAxisSize: MainAxisSize.min, children: [
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
                    const SizedBox(height: 24),
                    BlocBuilder<RegisterBloc, RegisterState>(
                      buildWhen: (previous, current) => current is GetProvincesSuccess || current is GetProvincesFailed,
                      builder: (context, state) {
                        return Dropdown<String>(
                          items: state is GetProvincesSuccess ? state.provinces : [],
                          label: 'Tỉnh / Thành phố',
                          onChanged: (grade) {
                            province = grade;
                            district = school = null;

                            bloc.add(GetDistricts(grade ?? ''));
                          },
                        );
                      },
                    ),
                    const SizedBox(height: 24),
                    BlocBuilder<RegisterBloc, RegisterState>(
                      buildWhen: (previous, current) => current is GetDistrictsSuccess || current is GetDistrictsFailed,
                      builder: (context, state) {
                        return Dropdown<String>(
                          key: UniqueKey(),
                          items: state is GetDistrictsSuccess ? state.districts : [],
                          label: 'Quận / Huyện',
                          onChanged: (grade) {
                            district = grade;
                            school = null;

                            bloc.add(GetSchools(district ?? ''));
                          },
                        );
                      },
                    ),
                    const SizedBox(height: 24),
                    const Text('Bạn là', style: AppTextTheme.interRegular14),
                    const RadioButton(items: ['Học sinh', 'Giáo viên']),
                    Row(children: [
                      Expanded(
                        flex: 260,
                        child: BlocBuilder<RegisterBloc, RegisterState>(
                          buildWhen: (previous, current) => current is GetSchoolsSuccess || current is GetSchoolsFailed,
                          builder: (context, state) {
                            return Dropdown(
                              key: UniqueKey(),
                              items: state is GetSchoolsSuccess ? state.schools : [],
                              label: 'Trường',
                              onChanged: (grade) {
                                school = grade;

                                bloc.add(GetClasses(grade));
                              },
                            );
                          },
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        flex: 73,
                        child: BlocBuilder<RegisterBloc, RegisterState>(
                          buildWhen: (previous, current) => current is GetClassesSuccess || current is GetClassesFailed,
                          builder: (context, state) {
                            return Dropdown(
                              key: UniqueKey(),
                              items: state is GetClassesSuccess ? state.classes : [],
                              label: 'Lớp',
                              onChanged: (grade) {
                                _class = grade;
                              },
                            );
                          },
                        ),
                      ),
                    ]),
                    const SizedBox(height: 24),
                    ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColor.purple01,
                        padding: const EdgeInsets.symmetric(vertical: 15),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
                      ),
                      child: const Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                        Text('Đăng ký', style: AppTextTheme.interMedium14),
                      ]),
                    )
                  ]),
                ),
              ),
            )
          ]),
        ),
      ),
    );
  }
}
