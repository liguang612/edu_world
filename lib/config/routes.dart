import 'package:edu_world/model/entity/user.dart';
import 'package:edu_world/view/account/edit_account.dart';
import 'package:edu_world/view/course/create_course.dart';
import 'package:edu_world/view/home/home.dart';
import 'package:edu_world/view/login/login.dart';
import 'package:edu_world/view/onboarding/onboarding.dart';
import 'package:edu_world/view/register/register.dart';
import 'package:edu_world/view/splash/splash.dart';
import 'package:flutter/material.dart';

class AppRoute {
  // Authentication
  static const String editAccount = '/editAccount';
  static const String login = '/login';
  static const String onboarding = '/onboarding';
  static const String register = '/register';

  // Course
  static const String createCourse = '/createCourse';

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
        return MaterialPageRoute(builder: (context) => CreateCourse(), settings: settings);

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
