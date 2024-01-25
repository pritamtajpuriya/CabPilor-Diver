import 'package:flutter/material.dart';
import '../presentation/pages/auth/pages/forgeot_password.dart';
import '../presentation/pages/auth/pages/register_screen.dart';

import '../presentation/pages/landing/pages/landing_screen.dart';
import '../presentation/pages/splash/splash_screen.dart';

import '../presentation/pages/auth/pages/login_screen.dart';

class AppRouter {
  static const String home = '/home';
  static const String login = '/login';
  static const String register = '/register';
  static const String landing = '/landing';
  static const String forgotPassword = '/forgot-password';
  static const String resetPassword = '/reset-password';
  static const String profile = '/profile';
  static const String editProfile = '/edit-profile';
  static const String changePassword = '/change-password';
  static const String changeLanguage = '/change-language';
  static const String changeTheme = '/change-theme';
  static const String category = '/category';
  static const String splash = '/';
  static const String courseContent = '/course-content';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case splash:
        return MaterialPageRoute(builder: (_) => const SplashScreen());
      case home:

      case login:
        return MaterialPageRoute(builder: (_) => LoginScreen());
      case register:
        return MaterialPageRoute(builder: (_) => RegisterScreen());

      case forgotPassword:
        return MaterialPageRoute(builder: (_) => ForgotPasswordScreen());

      case landing:
        return MaterialPageRoute(builder: (_) => LandingScreen());

      default:
        return MaterialPageRoute(
            builder: (_) => Scaffold(
                  body: Center(
                    child: Text('No route defined for ${settings.name}'),
                  ),
                ));

      // case register:
    }
  }
}
