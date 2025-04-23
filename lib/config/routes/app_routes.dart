import 'package:yaallo/features/auth/login/presentation/login_view.dart';
import 'package:yaallo/features/auth/reset/presentation/reset_view.dart';
import 'package:yaallo/features/auth/signup_brand/presentation/signup_brand_view.dart';
import 'package:yaallo/features/auth/splash/splash_view.dart';
import 'package:yaallo/features/bottom_navigation/nav_view.dart';
import 'package:yaallo/features/notification/presentation/notification_view.dart';

import '../../features/auth/signup_user/presentation/view/signup_user_view.dart';

class AppRoutes {
  AppRoutes._();

  static const String splashRoute = '/splash';
  static const String loginRoute = '/login';
  static const String signupUserRoute = '/user-signup';
  static const String signupBrandRoute = '/brand-signup';
  static const String resetRoute = '/reset';
  static const String homeRoute = '/home';
  static const String notificationRoute = '/notification';

  static getApplicationRoute() {
    return {
      splashRoute: (context) => const SplashView(),
      loginRoute: (context) => const LoginView(),
      signupUserRoute: (context) => const SignupUserView(),
      signupBrandRoute: (context) => const SignupBrandView(),
      resetRoute: (context) => const ResetView(),
      homeRoute: (context) => const NavView(),
      notificationRoute: (context) => const NotificationView(),
    };
  }
}
