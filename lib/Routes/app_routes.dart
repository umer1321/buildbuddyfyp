import 'package:get/get.dart';
import '../Views/DashBoard/Architect.dart';
import '../Views/DashBoard/Constructor.dart';
import '../Views/DashBoard/Contractor/RatingAndReviews.dart';
import '../Views/DashBoard/HomeOwner.dart';
import '../Views/DashBoard/Vendor.dart';
import '../views/Login/boardingscreen.dart';
import '../views/Login/startedScreen.dart';
import '../views/Login/loginPage.dart';
import '../views/Login/signUp.dart';
import '../views/Login/forgotPassword.dart';
import '../views/Login/splashScreen.dart';
// For HomeOwner features
import '../views/DashBoard/stakeholderSelection.dart';
import '../views/DashBoard/HomeOwner/findProfessionals.dart';
import '../views/DashBoard/HomeOwner/settings.dart';
import '../views/DashBoard/HomeOwner/myProjects.dart';
import '../views/DashBoard/HomeOwner/messages.dart';

// New screens for Contractor features
import '../views/DashBoard/Contractor/manageProjects.dart';
import '../views/DashBoard/Contractor/materialOrders.dart';
import '../views/DashBoard/Contractor/messages.dart';
import '../views/DashBoard/Contractor/payments.dart';
import '../views/DashBoard/Contractor/RatingAndReviews.dart';

 //For Architect features
import '../views/DashBoard/Architect/projectSubmission.dart';
import '../views/DashBoard/Architect/taskAssignment.dart';
import '../views/DashBoard/Architect/materialConsultations.dart';
import '../views/DashBoard/Architect/messages.dart';
import '../views/DashBoard/Architect/reviewAndFeedback.dart';

class AppRoutes {
  // Define routes for GetMaterialApp
  static final getPages = [
    GetPage(name: '/', page: () => const SplashScreen()),
    GetPage(name: '/boarding', page: () => const BoardingScreen()),
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

    // Dashboard routes
    GetPage(
      name: '/homeowner-dashboard',
      page: () => const HomeOwnerDashboard(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: '/contractor-dashboard',
      page: () => ContractorDashboard(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: '/architect-dashboard',
      page: () => ArchitectDashboard(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: '/vendor-dashboard',
      page: () => const VendorDashboard(),
      transition: Transition.fadeIn,
    ),

    // Contractor-specific routes
    GetPage(
      name: '/manage-projects',
      page: () => ManageProjectsScreen(),
    ),
    GetPage(
      name: '/material-orders',
      page: () => MaterialOrdersScreen(),
    ),
    GetPage(
      name: '/contractor-messages',
      page: () => MessagesScreen(),
    ),
    GetPage(
      name: '/payments',
      page: () => PaymentsScreen(),
    ),
    /*GetPage(
      name: '/ratings-reviews',
      page: () => RatingsReviewsScreen(),
    ),*/

    // Architect-specific routes
    GetPage(
      name: '/project-submissions',
      page: () => ProjectSubmissionsScreen(),
    ),
    GetPage(
      name: '/task-assignments',
      page: () => TaskAssignmentsScreen(),
    ),
    GetPage(
      name: '/material-consultations',
      page: () => MaterialConsultationsScreen(),
    ),
    GetPage(
      name: '/architect-messages',
      page: () => ArchitectMessagesScreen(),
    ),
    GetPage(
      name: '/reviews-feedback',
      page: () => ReviewsFeedbackScreen(),
    ),

    // Additional pages
    GetPage(
      name: '/find-professionals',
      page: () => const FindProfessionalsDashboard(),
    ),
    GetPage(
      name: '/settings',
      page: () => const SettingsDashboard(),
    ),
    GetPage(
      name: '/my-projects',
      page: () => const MyProjectsDashboard(),
    ),
    GetPage(
      name: '/messages',
      page: () => const MessagesDashboard(),
    ),
  ];
}


























/*
import 'package:get/get.dart';
import '../Views/DashBoard/Architect.dart';
import '../Views/DashBoard/Constructor.dart';
import '../Views/DashBoard/Contractor/RatingAndReviews.dart';
import '../Views/DashBoard/HomeOwner.dart';
import '../Views/DashBoard/Vendor.dart';
import '../views/Login/boardingscreen.dart';
import '../views/Login/startedScreen.dart';
import '../views/Login/loginPage.dart';
import '../views/Login/signUp.dart';
import '../views/Login/forgotPassword.dart';
import '../views/Login/splashScreen.dart';
// For HomeOwner features
import '../views/DashBoard/stakeholderSelection.dart';
import '../views/DashBoard/HomeOwner/findProfessionals.dart';
import '../views/DashBoard/HomeOwner/settings.dart';
import '../views/DashBoard/HomeOwner/myProjects.dart';
import '../views/DashBoard/HomeOwner/messages.dart';

// New screens for Contractor features
import '../views/DashBoard/Contractor/manageProjects.dart';
import '../views/DashBoard/Contractor/materialOrders.dart';
import '../views/DashBoard/Contractor/messages.dart';
import '../views/DashBoard/Contractor/payments.dart';
import '../views/DashBoard/Contractor/RatingAndReviews.dart';

class AppRoutes {
  // Define routes for GetMaterialApp
  static final getPages = [
    GetPage(name: '/', page: () => const SplashScreen()),
    GetPage(name: '/boarding', page: () => const BoardingScreen()),
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

    // Dashboard routes
    GetPage(
      name: '/homeowner-dashboard',
      page: () => const HomeOwnerDashboard(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: '/contractor-dashboard',
      page: () => ContractorDashboard(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: '/architect-dashboard',
      page: () => ArchitectDashboard(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: '/vendor-dashboard',
      page: () => const VendorDashboard(),
      transition: Transition.fadeIn,
    ),

    // Contractor-specific routes
    GetPage(
      name: '/manage-projects',
      page: () => ManageProjectsScreen(),
    ),
    GetPage(
      name: '/material-orders',
      page: () => MaterialOrdersScreen(),
    ),
    GetPage(
      name: '/contractor-messages',
      page: () => MessagesScreen(),
    ),
    GetPage(
      name: '/payments',
      page: () => PaymentsScreen(),
    ),
    */
/*GetPage(
      name: '/ratings-reviews',
      page: () => RatingsReviewsScreen(),
    ),*//*


    // Additional pages
    GetPage(
      name: '/find-professionals',
      page: () => const FindProfessionalsDashboard(),
    ),
    GetPage(
      name: '/settings',
      page: () => const SettingsDashboard(),
    ),
    GetPage(
      name: '/my-projects',
      page: () => const MyProjectsDashboard(),
    ),
    GetPage(
      name: '/messages',
      page: () => const MessagesDashboard(),
    ),
  ];
}

*/





























/*
import 'package:get/get.dart';
import '../Views/DashBoard/Architect.dart';
import '../Views/DashBoard/Constructor.dart';
import '../Views/DashBoard/HomeOwner.dart';
import '../Views/DashBoard/Vendor.dart';
import '../views/Login/boardingscreen.dart';
import '../views/Login/startedScreen.dart';
import '../views/Login/loginPage.dart';
import '../views/Login/signUp.dart';
import '../views/Login/forgotPassword.dart';
import '../views/Login/splashScreen.dart';
import '../views/DashBoard/stakeholderSelection.dart';
import '../views/DashBoard/HomeOwner/findProfessionals.dart';
import '../views/DashBoard/HomeOwner/settings.dart';
import '../views/DashBoard/HomeOwner/myProjects.dart';
import '../views/DashBoard/HomeOwner/messages.dart';


class AppRoutes {
  // Define routes for GetMaterialApp
  static final getPages = [
    GetPage(name: '/', page: () => const SplashScreen()),
    GetPage(name: '/boarding', page: () => const BoardingScreen()),
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

    // Dashboard routes
    GetPage(
      name: '/homeowner-dashboard',
      page: () => const HomeOwnerDashboard(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: '/contractor-dashboard',
      page: () => ContractorDashboard(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: '/architect-dashboard',
      page: () => const ArchitectDashboard(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: '/vendor-dashboard',
      page: () => const VendorDashboard(),
      transition: Transition.fadeIn,
    ),



    // Additional pages

    GetPage(name: '/find-professionals', page: () => const FindProfessionalsDashboard()),
    GetPage(name: '/settings', page: () => const SettingsDashboard()),
    GetPage(name: '/my-projects', page: () => const MyProjectsDashboard()),
    GetPage(name: '/messages', page: () => const MessagesDashboard()),




  ];
}

*/






/*
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

*/




























