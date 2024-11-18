/*import 'package:buildbuddyfyp/Models/userModels.dart';
import 'package:flutter/material.dart';
import 'package:buildbuddyfyp/Models/userModels.dart';
import '../../Controllers/authControllers.dart';
import 'package:buildbuddyfyp/Views/Shared/widgets/input_field.dart';
import 'package:buildbuddyfyp/Views/Shared/widgets/custom_button.dart';


class LoginScreen extends StatefulWidget{
  @override
  _LoginScreenState createState() => _LoginScreenState();

}
class _LoginScreenState extends State<LoginScreen>{
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _authController = AuthController();

  Future<void> _signInWithEmailAndPassword() async {
    final credentials = UserCredentials(
        email: _emailController.text,
        password: _passwordController.text,
    );
    await _authController.signInWithEmailAndPassword(credentials);
  }

  Future<void> _signInWithGoogle() async {
    await _authController.signInWithGoogle();
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
      body:Padding(padding:const EdgeInsets.all(24.0),
      child:Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          InputField(
            controller:_emailController,
            hintText: 'Email'
          ),
          const SizedBox(height: 16.0),
          InputField(
            controller:_passwordController,
            hintText: 'Password',
            obscureText: true,
          ),
          const SizedBox(height: 24.0),
          CustomButton(
            text: 'Sign In',
            onPressed: _signInWithEmailAndPassword
          ),
          const SizedBox(height: 16.0),
          CustomButton(
            text: 'Sign In with Google',
            onPressed: _signInWithGoogle
          ),
          const SizedBox(height: 16.0),
          TextButton(onPressed: (){},
              child: const Text('Forgot Password?'),),


        ],
      ),

      ),
    );
  }
}*/