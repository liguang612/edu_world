import 'package:edu_world/bloc/register/register_bloc.dart';
import 'package:edu_world/data/resources/colors.dart';
import 'package:edu_world/data/resources/resources.dart';
import 'package:edu_world/data/resources/theme.dart';
import 'package:edu_world/di/di.dart';
import 'package:edu_world/shared/utils/ext/build_context_ext.dart';
import 'package:edu_world/shared/widgets/dropdown.dart';
import 'package:edu_world/shared/widgets/radio_button.dart';
import 'package:edu_world/view/onboarding/onboarding.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Register extends StatelessWidget {
  final RegisterBloc bloc = getIt.get();

  final TextEditingController birthController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();

  String? province, district, school;
  int _class = 0;
  final GlobalKey<RadioButtonState> roleKey = GlobalKey();
  DateTime? birth;

  Register({super.key}) {
    bloc.add(GetProvince());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.backgroundColor,
      body: BlocProvider.value(
        value: bloc,
        child: BlocListener<RegisterBloc, RegisterState>(
          listener: (context, state) {
            if (state is RegisterUserSuccess) {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const Onboarding(),
                  ));
            } else if (state is RegisterUserFailed) {
              Fluttertoast.showToast(msg: state.message);
            }
          },
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
                      decoration: InputDecoration(
                          contentPadding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
                          hintStyle: AppTextTheme.interRegular14,
                          hintText: 'Ngày sinh',
                          isDense: true,
                          suffixIcon: IconButton(
                            onPressed: () {
                              print('selectdate');
                              _selectDate(context);
                            },
                            icon: const Icon(Icons.edit_calendar_outlined, color: AppColor.gray02),
                          )),
                      readOnly: true,
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
                            _class = 0;

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
                    RadioButton(key: roleKey, items: const ['Học sinh', 'Giáo viên']),
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
                                _class = 0;

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
                              onChanged: (grade) => _class = grade,
                            );
                          },
                        ),
                      ),
                    ]),
                    const SizedBox(height: 24),
                    ElevatedButton(
                      onPressed: _onRegisterSubmit,
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

  Future<void> _selectDate(BuildContext context) async {
    final now = DateTime.now();

    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: now.subtract(const Duration(days: 365 * 6)),
      firstDate: now.subtract(const Duration(days: 365 * 100)),
      lastDate: now.subtract(const Duration(days: 365 * 6)),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: AppColor.purple01,
              onPrimary: AppColor.white,
              onSurface: AppColor.black,
            ),
          ),
          child: child!,
        );
      },
    );

    if (picked != null) {
      birth = picked;

      // Format the date as dd/MM/yyyy
      final formattedDate = "${picked.day.toString().padLeft(2, '0')}/"
          "${picked.month.toString().padLeft(2, '0')}/"
          "${picked.year}";
      birthController.text = formattedDate;
    }
  }

  void _onRegisterSubmit() {
    bloc.add(RegisterSubmit(
      name: nameController.text.trim(),
      birth: birth,
      phone: phoneController.text.trim(),
      province: province,
      district: district,
      role: roleKey.currentState?.indexSelected,
      school: school,
      Class: _class,
    ));
  }
}
