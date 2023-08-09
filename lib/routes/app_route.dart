import 'package:flutter/material.dart';
import 'package:project_gt/presentation/screens/home_page_screen.dart';
import 'package:project_gt/presentation/screens/loading_page.dart';
import 'package:project_gt/presentation/screens/login_page.dart';
import 'package:project_gt/presentation/screens/profile_page.dart';
import 'package:project_gt/presentation/screens/sign_up_page.dart';

class AppRoutes {
  static const String loading = '/loading';
  static const String home = '/';
  static const String logIn = '/login';
  static const String signUp = '/signup';
  static const String profile = '/profile';
}

Route<dynamic> onGenerateRoute(RouteSettings settings) {
  switch (settings.name) {
    case AppRoutes.loading:
      return MaterialPageRoute(builder: (context) => LoadingPage());
    case AppRoutes.home:
      return MaterialPageRoute(builder: (context) => HomePageScreen());
    case AppRoutes.logIn:
      return MaterialPageRoute(builder: (context) => Login());
    case AppRoutes.signUp:
      return MaterialPageRoute(builder: (context) => SignUp());
    case AppRoutes.profile:
      return MaterialPageRoute(builder: (context) => ProfilePage());
    default:
      throw Exception('This route name does not exist: ${settings.name}');
  }
}
