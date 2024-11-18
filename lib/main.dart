import 'package:flutter/material.dart';
import 'package:buildbuddyfyp/Routes/app_routes.dart';
import 'package:buildbuddyfyp/Core/Theme/theme.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized(); // Ensure Flutter bindings are initialized
  await Firebase.initializeApp(); // Initialize Firebase
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'BuildBuddy',
      theme: AppTheme.lightTheme,
      initialRoute: '/',
      routes: AppRoutes.routes,
    );
  }
}
