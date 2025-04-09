// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:edu_world/bloc/course/course_bloc.dart';
import 'package:edu_world/model/entity/course.dart';
import 'package:edu_world/model/entity/user.dart';
import 'package:edu_world/view/account/edit_account.dart';
import 'package:edu_world/view/course/course_detail.dart';
import 'package:edu_world/view/course/create_course.dart';
import 'package:edu_world/view/home/home.dart';
import 'package:edu_world/view/login/login.dart';
import 'package:edu_world/view/onboarding/onboarding.dart';
import 'package:edu_world/view/register/register.dart';
import 'package:edu_world/view/splash/splash.dart';

class AppRoute {
  // Authentication
  static const String editAccount = '/editAccount';
  static const String login = '/login';
  static const String onboarding = '/onboarding';
  static const String register = '/register';

  // Course
  static const String createCourse = '/createCourse';
  static const String detailCourse = '/detailCourse';

  // Home
  static const String home = '/home';

  // Splash
  static const String splash = '/';

  static Route? onGenerateRoute(RouteSettings settings) {
    switch (settings.name!) {
      // Authentication
      case AppRoute.editAccount:
        return MaterialPageRoute(builder: (context) => const EditAccount(), settings: settings);
      case AppRoute.login:
        return MaterialPageRoute(builder: (context) => Login(), settings: settings);
      case AppRoute.onboarding:
        return MaterialPageRoute(builder: (context) => const Onboarding(), settings: settings);
      case AppRoute.register:
        return MaterialPageRoute(builder: (context) => Register(), settings: settings);

      // Course
      case AppRoute.createCourse:
        return MaterialPageRoute(builder: (context) => const CreateCourse(), settings: settings);
      case AppRoute.detailCourse:
        return MaterialPageRoute(builder: (context) => const CourseDetail(), settings: settings);

      // Home
      case AppRoute.home:
        return MaterialPageRoute(builder: (context) => const Home(), settings: settings);

      // Splash
      case AppRoute.splash:
        return MaterialPageRoute(builder: (context) => Splash(), settings: settings);

      default:
        return null;
    }
  }
}

class CourseDetailArgs {
  final Course course;
  final CourseBloc bloc;

  const CourseDetailArgs(this.course, this.bloc);
}

class EditAccountArgs {
  final User user;

  const EditAccountArgs(this.user);
}

class HomepageArgs {
  final User user;

  const HomepageArgs(this.user);
}

class OnboardingArgs {
  final User user;

  const OnboardingArgs(this.user);
}
