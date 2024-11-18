
/*import 'package:flutter/material.dart';

import '../../Controllers/authControllers.dart';
import '../../Models/userModels.dart';
import 'package:buildbuddyfyp/Views/Shared/widgets/input_field.dart';
import 'package:buildbuddyfyp/Views/Shared/widgets/custom_button.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}


  class _SignUpScreenState extends State<SignUpScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _authController = AuthController();

  Future<void> _signUpWithEmail() async {
  if (_passwordController.text != _confirmPasswordController.text) {
  // Show error message
  return;
  }
  final credentials = UserCredentials(
  email: _emailController.text,
  password: _passwordController.text,
  );
  await _authController.createUserWithEmailAndPassword(credentials);
  }

  Future<void> _signUpWithGoogle() async {
  await _authController.signInWithGoogle();
  }

  @override
  Widget build(BuildContext context) {
  return Scaffold(
  body: Padding(
  padding: const EdgeInsets.all(24.0),
  child: Column(
  mainAxisAlignment: MainAxisAlignment.center,
  children: [
  // Sign Up screen UI
  InputField(controller: _emailController, hintText: 'Email'),
  const SizedBox(height: 16.0),
  InputField(
  controller: _passwordController,
  hintText: 'Password',
  obscureText: true,
  ),
  const SizedBox(height: 16.0),
  InputField(
  controller: _confirmPasswordController,
  hintText: 'Confirm Password',
  obscureText: true,
  ),
  const SizedBox(height: 24.0),
  CustomButton(text: 'Sign Up', onPressed: _signUpWithEmail),
  const SizedBox(height: 16.0),
  CustomButton(
  text: 'Sign Up with Google',
  onPressed: _signUpWithGoogle,
  ),
  const SizedBox(height: 16.0),
  TextButton(
  onPressed: () {
  // Navigate to LoginScreen
  },
  child: const Text('Already have an account? Sign In'),
  ),
  ],
  ),
  ),
  );
  }
  }

*/
