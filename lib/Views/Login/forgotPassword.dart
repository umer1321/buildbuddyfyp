
/*import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:buildbuddyfyp/Views/Shared/widgets/input_field.dart';
import 'package:buildbuddyfyp/Views/Shared/widgets/custom_button.dart';

import '../../Controllers/authControllers.dart';


class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  _ForgotPasswordScreenState createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final _emailController = TextEditingController();
  final _authController = AuthController();

  Future<void> _resetPassword() async {
    await _authController.sendPasswordResetEmail(_emailController.text);
    showSnackBar(context, 'Password reset email sent');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Forgot Password screen UI
            InputField(controller: _emailController, hintText: 'Email'),
            const SizedBox(height: 24.0),
            CustomButton(text: 'Reset Password', onPressed: _resetPassword),
            const SizedBox(height: 16.0),
            TextButton(
              onPressed: () {
                // Navigate to LoginScreen
              },
              child: const Text('Back to Sign In'),
            ),
          ],
        ),
      ),
    );
  }
}*/