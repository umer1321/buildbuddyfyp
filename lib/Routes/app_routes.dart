import 'package:flutter/material.dart';


import '../Views/Login/boardingscreen.dart';
import '../views/Login/startedScreen.dart';
import '../views/Login/loginPage.dart';
import '../views/Login/signUp.dart';
import '../views/Login/forgotPassword.dart';
import '../views/Login/splashScreen.dart';
import '../Views/DashBoard/stakeholderSelection.dart';
//import 'package:buildbuddyfyp/Splash/splashScreen.dart';

class AppRoutes {
  static Map<String, WidgetBuilder> routes = {
    '/': (context) => const SplashScreen(),          // Initial route - Splash screen
    '/boarding': (context) => const BoardingScreen(), // Boarding screen
    '/get-started': (context) => const GetStartedScreen(), // Get started screen
    '/sign-in': (context) => const SignInScreen(),    // Sign in screen
    '/sign-up': (context) => const SignUpScreen(),    // Sign up screen
    '/forgot-password': (context) => const ForgotPasswordScreen(), // Forgot password screen
    '/stakeholder': (context) => const StakeholderSelection(), // Stakeholder selection screen
  };
}




/*import 'package:flutter/material.dart';

import '../Views/Login/boardingscreen.dart';
import '../views/Login/startedScreen.dart';
import '../views/Login/loginPage.dart';
import '../views/Login/signUp.dart';
import '../views/Login/forgotPassword.dart';
import '../views/Login/splashScreen.dart';
//import 'package:buildbuddyfyp/Splash/splashScreen.dart';

class AppRoutes {
  static Map<String, WidgetBuilder> routes = {
    '/': (context) => const SplashScreen(),
    '/boarding': (context) => const BoardingScreen(),
    '/get-started': (context) => const GetStartedScreen(),
    '/sign-in': (context) => const SignInScreen(),
    '/sign-up': (context) => const SignUpScreen(),
    '/forgot-password': (context) => const ForgotPasswordScreen(),
  };
}*/