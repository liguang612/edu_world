import 'package:edu_world/bloc/account/account_bloc.dart';
import 'package:edu_world/bloc/register/register_bloc.dart';
import 'package:edu_world/config/routes.dart';
import 'package:edu_world/data/resources/colors.dart';
import 'package:edu_world/data/resources/theme.dart';
import 'package:edu_world/di/di.dart';
import 'package:edu_world/model/entity/user.dart';
import 'package:edu_world/shared/utils/ext/build_context_ext.dart';
import 'package:edu_world/shared/utils/ext/date_time_ext.dart';
import 'package:edu_world/shared/widgets/dropdown.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// ignore: must_be_immutable
class EditAccount extends StatefulWidget {
  const EditAccount({super.key});

  @override
  State<EditAccount> createState() => _EditRegisterState();
}

class _EditRegisterState extends State<EditAccount> {
  bool _isInitialized = false;

  final RegisterBloc bloc = getIt.get();

  late final User user;

  final TextEditingController birthController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();

  String? district, province, school;
  int? _class;
  DateTime? birth;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    if (!_isInitialized) {
      user = (context.arguments as EditAccountArgs).user;

      birthController.text = (birth = user.birthday).formattedString;
      nameController.text = user.name.toString();
      phoneController.text = user.phone.toString();

      province = user.province;
      district = user.district;
      school = user.school;
      _class = user.grade;

      bloc.add(GetProvince());
      bloc.add(GetDistricts(province!));
      bloc.add(GetSchools(district!));
      bloc.add(GetClasses(user.school));

      _isInitialized = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColor.transparent,
        title: const Text('Thay đổi thông tin', style: AppTextTheme.interBold16),
      ),
      backgroundColor: AppColor.backgroundColor,
      body: BlocProvider.value(
        value: bloc,
        child: BlocListener<RegisterBloc, RegisterState>(
          listener: (context, state) {
            if (state is RegisterUserSuccess) {
              final AccountBloc accountBloc = getIt.get();
              accountBloc.add(GetAccountInfo());

              Navigator.pop(context);
            }
          },
          child: Container(
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.only(topLeft: Radius.circular(40), topRight: Radius.circular(40)),
              boxShadow: [
                BoxShadow(blurRadius: 10, color: AppColor.black.withOpacity(0.09), offset: const Offset(0, -5))
              ],
              color: AppColor.white,
            ),
            margin: const EdgeInsets.only(top: 8),
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 36),
            width: context.screenWidth,
            child: SingleChildScrollView(
              child: Column(crossAxisAlignment: CrossAxisAlignment.start, mainAxisSize: MainAxisSize.min, children: [
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
                        onPressed: () => _selectDate(context),
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
                      initialValue: province,
                      label: 'Tỉnh / Thành phố',
                      onChanged: (value) {
                        province = value;
                        district = school = _class = null;

                        bloc.add(GetDistricts(value ?? ''));
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
                      initialValue: district,
                      items: state is GetDistrictsSuccess ? state.districts : [],
                      label: 'Quận / Huyện',
                      onChanged: (value) {
                        district = value;
                        school = _class = null;

                        bloc.add(GetSchools(district ?? ''));
                      },
                    );
                  },
                ),
                const SizedBox(height: 24),
                Row(children: [
                  Expanded(
                    flex: 260,
                    child: BlocBuilder<RegisterBloc, RegisterState>(
                      buildWhen: (previous, current) => current is GetSchoolsSuccess || current is GetSchoolsFailed,
                      builder: (context, state) {
                        return Dropdown(
                          key: UniqueKey(),
                          initialValue: school,
                          items: state is GetSchoolsSuccess ? state.schools : [],
                          label: 'Trường',
                          onChanged: (grade) {
                            school = grade;
                            _class = null;

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
                          initialValue: _class,
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
                  onPressed: _onEditSubmitted,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColor.purple01,
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
                  ),
                  child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                    BlocBuilder<RegisterBloc, RegisterState>(
                      builder: (context, state) {
                        if (state is Registering) {
                          return const CircularProgressIndicator();
                        }
                        return const Text('Xong', style: AppTextTheme.interMedium14);
                      },
                    ),
                  ]),
                ),
              ]),
            ),
          ),
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

    if (picked != null) birthController.text = (birth = picked).formattedString;
  }

  void _onEditSubmitted() {
    bloc.add(RegisterSubmit(
      name: nameController.text.trim(),
      birth: birth,
      phone: phoneController.text.trim(),
      province: province,
      district: district,
      role: user.role,
      school: school,
      Class: _class ?? 0,
    ));
  }
}
