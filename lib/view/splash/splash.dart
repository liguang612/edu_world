import 'package:edu_world/bloc/splash/splash_bloc.dart';
import 'package:edu_world/data/resources/resources.dart';
import 'package:edu_world/di/di.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

class Splash extends StatelessWidget {
  final SplashBloc bloc = getIt.get();

  Splash({super.key}) {
    bloc.add(SplashEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<SplashBloc, SplashState>(
        bloc: bloc,
        listener: (context, state) {
          if (state is GetNextRouteSuccess) {
            Navigator.popAndPushNamed(
              context,
              state.nextRoute,
              arguments: state.arguments,
            );
          }
        },
        child: Center(
          child: SvgPicture.asset(Assets.icLogo, height: 71.14, width: 87),
        ),
      ),
    );
  }
}
