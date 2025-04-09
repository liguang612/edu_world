import 'package:edu_world/bloc/login/login_bloc.dart';
import 'package:edu_world/data/resources/colors.dart';
import 'package:edu_world/data/resources/resources.dart';
import 'package:edu_world/data/resources/theme.dart';
import 'package:edu_world/di/di.dart';
import 'package:edu_world/shared/utils/ext/build_context_ext.dart';
import 'package:edu_world/view/onboarding/onboarding.dart';
import 'package:edu_world/view/register/register.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Login extends StatelessWidget {
  final LoginBloc bloc = getIt.get();

  Login({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.backgroundColor,
      body: BlocListener<LoginBloc, LoginState>(
        bloc: bloc,
        listener: (context, state) {
          if (state is RegisterNewUserState) {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => Register(),
                ));
          } else if (state is LoginSuccessState) {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const Onboarding(),
                ));
          } else if (state is LoginFailedState) {
            Fluttertoast.showToast(msg: 'Có lỗi xảy ra! Vui lòng thử lại');
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
              const Text('Xin chào', style: AppTextTheme.interRegular24)
            ]),
          ),
          Container(
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.only(topLeft: Radius.circular(40), topRight: Radius.circular(40)),
              boxShadow: [
                BoxShadow(blurRadius: 50, color: AppColor.black.withOpacity(0.09), offset: const Offset(0, -4))
              ],
              color: AppColor.white,
            ),
            height: context.screenHeight * 483 / 812,
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 56),
            width: context.screenWidth,
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              const Text('Đăng nhập', style: AppTextTheme.interRegular18),
              const Spacer(),
              Padding(
                padding: const EdgeInsets.all(45),
                child: ElevatedButton(
                    onPressed: () => bloc.add(LoginWithGoogle()),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColor.purple01,
                      padding: const EdgeInsets.symmetric(vertical: 15),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
                    ),
                    child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                      SvgPicture.asset(Assets.icGoogle),
                      const SizedBox(width: 22),
                      const Text('Đăng nhập với Google', style: AppTextTheme.interMedium14)
                    ])),
              ),
              const Spacer(),
            ]),
          )
        ]),
      ),
    );
  }
}
