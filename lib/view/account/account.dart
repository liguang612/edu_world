import 'package:edu_world/bloc/account/account_bloc.dart';
import 'package:edu_world/config/routes.dart';
import 'package:edu_world/data/resources/colors.dart';
import 'package:edu_world/data/resources/resources.dart';
import 'package:edu_world/data/resources/theme.dart';
import 'package:edu_world/di/di.dart';
import 'package:edu_world/model/entity/user.dart';
import 'package:edu_world/shared/utils/ext/build_context_ext.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Account extends StatelessWidget {
  final AccountBloc bloc = getIt.get();

  Account({super.key}) {
    bloc.add(GetAccountInfo());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider.value(
        value: bloc,
        child: BlocBuilder<AccountBloc, AccountState>(
          builder: (context, state) {
            return Column(children: [
              Expanded(
                child: SizedBox(
                  width: context.screenWidth,
                  child: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
                    const SizedBox(height: 50),
                    state is GetAccountInfoSuccess
                        ? ClipOval(
                            child: Image.network(
                              state.user.avatarUrl ?? '',
                              fit: BoxFit.cover,
                              height: context.screenWidth * 100 / 375,
                              width: context.screenWidth * 100 / 375,
                            ),
                          )
                        : const CircularProgressIndicator(),
                    const SizedBox(height: 20),
                    Text(
                      state is GetAccountInfoSuccess ? state.user.name : '',
                      style: AppTextTheme.interMedium24,
                    ),
                    Text(
                      state is GetAccountInfoSuccess ? state.user.email ?? '' : '',
                      style: AppTextTheme.interRegular16,
                    ),
                    const SizedBox(height: 25),
                    InfoItem(
                      icon: SvgPicture.asset(Assets.icProfile, height: 24, width: 24),
                      title: 'Tên',
                      value: state is GetAccountInfoSuccess ? state.user.name : '',
                    ),
                    InfoItem(
                      icon: SvgPicture.asset(Assets.icPhone, height: 24, width: 24),
                      title: 'Số điện thoại',
                      value: state is GetAccountInfoSuccess ? state.user.phone : '--- - --- - ----',
                    ),
                    InfoItem(
                      icon: const Icon(Icons.school, color: AppColor.purple01),
                      title: 'Trường',
                      value: state is GetAccountInfoSuccess ? state.user.school : '',
                    ),
                    InfoItem(
                      icon: const Icon(Icons.location_city, color: AppColor.purple01),
                      title: 'Địa điểm',
                      value: state is GetAccountInfoSuccess ? state.user.address() : '',
                    ),
                    InfoItem(
                      icon: const Icon(Icons.class_, color: AppColor.purple01),
                      title: 'Lớp',
                      value: '${state is GetAccountInfoSuccess ? state.user.grade : ''}',
                    )
                  ]),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(15),
                child: Row(children: [
                  Expanded(
                      child: TextButton(
                    onPressed: () {
                      if (state is GetAccountInfoSuccess) {
                        _onEdit(context, state.user);
                      } else {
                        Fluttertoast.showToast(msg: 'Đang đợi lấy thông tin');
                      }
                    },
                    child: const Text('Chỉnh sửa', style: AppTextTheme.interSemiBold18),
                  )),
                  const SizedBox(
                    height: 24,
                    width: 4,
                    child: VerticalDivider(color: AppColor.gray04, width: 4),
                  ),
                  Expanded(
                      child: TextButton(
                    onPressed: _onLogout,
                    child: BlocConsumer<AccountBloc, AccountState>(
                      listener: (context, state) {
                        if (state is LoggedOutFailed) {
                          Fluttertoast.showToast(msg: 'Có lỗi xảy ra');
                        } else if (state is LoggedOutSuccess) {
                          Navigator.pushNamedAndRemoveUntil(context, AppRoute.login, (route) => false);
                        }
                      },
                      builder: (context, state) {
                        if (state is LoggingOutState) {
                          return const CircularProgressIndicator(color: AppColor.red01);
                        }
                        return Text(
                          'Đăng xuất',
                          style: AppTextTheme.interSemiBold18.copyWith(color: AppColor.red01),
                        );
                      },
                    ),
                  )),
                ]),
              )
            ]);
          },
        ),
      ),
    );
  }

  void _onEdit(BuildContext context, User user) {
    Navigator.pushNamed(
      context,
      AppRoute.editAccount,
      arguments: EditAccountArgs(user),
    );
  }

  void _onLogout() => bloc.add(Logout());
}

class InfoItem extends StatelessWidget {
  final Widget icon;
  final String title;
  final String value;
  final bool isEditable;

  const InfoItem({
    super.key,
    required this.icon,
    this.isEditable = true,
    required this.title,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(6),
              boxShadow: [
                BoxShadow(
                  blurRadius: 30,
                  color: AppColor.black.withOpacity(0.15),
                  offset: const Offset(0, 4),
                )
              ],
              color: AppColor.white),
          child: Padding(
            padding: const EdgeInsets.all(4),
            child: icon,
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(title, style: AppTextTheme.interMedium14.copyWith(color: AppColor.black)),
            const SizedBox(height: 6),
            Text(value, style: AppTextTheme.interRegular12.copyWith(color: AppColor.gray03)),
          ]),
        ),
      ]),
    );
  }
}
