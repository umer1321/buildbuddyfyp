import 'package:get/get.dart';
import '../views/Login/boardingscreen.dart';
import '../views/Login/startedScreen.dart';
import '../views/Login/loginPage.dart';
import '../views/Login/signUp.dart';
import '../views/Login/forgotPassword.dart';
import '../views/Login/splashScreen.dart';
import '../views/DashBoard/stakeholderSelection.dart';

class AppRoutes {
  // Define routes for GetMaterialApp
  static final getPages = [
    GetPage(name: '/', page: () => const SplashScreen()),          // Initial route - Splash screen
    GetPage(name: '/boarding', page: () => const BoardingScreen()), // Boarding screen
    GetPage(
      name: '/get-started',
      page: () => const GetStartedScreen(),
      transition: Transition.fadeIn,
      binding: BindingsBuilder(() {
        Get.put(GetStartedScreen());
      }),
    ),
    GetPage(name: '/sign-in', page: () => const SignInScreen()),
    GetPage(name: '/sign-up', page: () => const SignUpScreen()),
    GetPage(name: '/forgot-password', page: () => const ForgotPasswordScreen()),
    GetPage(name: '/stakeholder', page: () => const StakeholderSelection()),
  ];
}





























