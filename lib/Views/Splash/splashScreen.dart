
/*import 'package:flutter/material.dart';
import 'package:buildbuddyfyp/Routes/app_routes.dart';



class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  SplashScreenState createState() => SplashScreenState();
}

class SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _navigateToNextScreen();
  }

  Future<void> _navigateToNextScreen() async {
    // Simulate some loading or initialization process
    await Future.delayed(const Duration(seconds: 5));

    // Navigate to the appropriate screen based on authentication state
    if (await _isUserAuthenticated()) {
      // Navigate to the appropriate dashboard screen
     // Navigator.pushNamed(context, AppRoutes.homeownerDashboard);
    } else {
      // Navigate to the login screen
      Navigator.pushNamed(context, AppRoutes.login);
    }
  }

  Future<bool> _isUserAuthenticated() async {
    // Implement the logic to check if the user is authenticated
    // (e.g., check if the user has a valid session or token)
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/images/logo.png', width: 100),
            const SizedBox(height: 16.0),
            Text(
              'BuildBuddy',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
      ),
    );
  }
}*/