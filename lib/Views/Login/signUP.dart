import 'package:buildbuddyfyp/Views/shared/widgets/custom_button.dart';
import 'package:buildbuddyfyp/Views/Login/loginPage.dart';
import 'package:flutter/material.dart';
import '../../Controllers/authControllers.dart';
import '../../Models/userModels.dart';
import '../Shared/widgets/input_field.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}


class _SignUpScreenState extends State<SignUpScreen> {

  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  bool _isLoading = false;
  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;
  final _authController = AuthController();


    @override
    void dispose() {
    super.dispose();
      _emailController.dispose();
      _passwordController.dispose();
      _confirmPasswordController.dispose();
      //super.dispose();
    }
  void _handleSignUp() async {
    if (_formKey.currentState?.validate() ?? false) {
      setState(() => _isLoading = true);

      try {
        await _authController.createUserWithEmailAndPassword(
          UserCredentials(
            email: _emailController.text.trim(),
            password: _passwordController.text,
          ),
        );

        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Account created successfully!')),
          );
          // Navigate to login or home page
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (_) => const SignInScreen()),
          );
        }
      } catch (e) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Error: ${e.toString()}')),
          );
        }
      } finally {
        if (mounted) {
          setState(() => _isLoading = false);
        }
      }
    }
  }


  // Updated color scheme
    static const Color darkBlue = Color(0xFF1A1A60);     // Deeper blue for large circles
    static const Color mediumBlue = Color(0xFF3939DD);   // Lighter blue for small circle and button
    static const Color lightGrey = Color(0xFFF8F8F8);    // Light grey for input fields
    static const Color darkGrey = Color(0xFF2E2E2E);     // Dark grey for main text
    static const Color secondaryGrey = Color(0xFF757575); // Secondary text color
    static const Color royalBlue = Color(0xFF3F3FDD);    // Brighter blue for button
    static const Color navyBlue = Color(0xFF0A0E55);
    static const Color midnightBlue = Color(0xFF191970);
    static const Color grayBlue = Color(0xFF6699CC);
    static const Color moreBlue = Color(0xFF87CEEB);  // SkyBlue


@override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          // Large top right circle - dark blue
          Positioned(
            top: -160,
            right: -100,
            child: Container(
              width: 330,
              height: 320,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color:Colors.blue,
              ),
            ),
          ),
          // Smaller overlapping circle - medium blue
          Positioned(
            top: 70,
            right: -70,
            child: Container(
              width: 200,
              height: 200,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: darkBlue,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 10,
                    offset: Offset(0, 4),
                  ),
                ],
              ),
            ),
          ),
          // Bottom left circle - dark blue
          Positioned(
            bottom: -160,
            left: -100,
            child: Container(
              width: 450,
              height: 350,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: darkBlue,
              ),
            ),
          ),
          // Bottom right circle - medium blue
          Positioned(
            bottom: -120,
            right: -80,
            child: Container(
              width: 250,
              height: 350,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.blue,
              ),
            ),
          ),
          // Main content
          SafeArea(
           // child:SingleChildScrollView()
            child: Padding(
              padding: const EdgeInsets.all( 24.0),
              child: Form(

                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 130),
                    const Text(
                      'Sign Up',
                      style: TextStyle(
                        fontSize: 50,
                        fontWeight: FontWeight.w900,
                        color: darkBlue,
                        height: 1.2,
                      ),
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      'Hello! let\'s join with us',
                      style: TextStyle(
                        fontSize: 18.5,
                        color: secondaryGrey,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    const SizedBox(height: 50),
                    InputField(
                      controller: _emailController,
                      hintText: 'Email',
                      prefixIcon: Icons.mail_outline,
                      keyboardType: TextInputType.emailAddress,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your email';
                        }
                        if(!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)){
                          return 'Please enter a valid email';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),
                    InputField(
                      controller: _passwordController,
                      hintText: 'Password',
                      prefixIcon: Icons.lock_outline,
                      obscureText: _obscurePassword,
                      suffixIcon: IconButton(
                        icon: Icon(_obscurePassword ? Icons.visibility : Icons.visibility_off),
                        onPressed: () => setState(() => _obscurePassword = !_obscurePassword),
                      ),

                      validator: PasswordValidator.validatePassword,
                      
                    ),
                    const SizedBox(height: 16),
                    InputField(
                      controller: _confirmPasswordController,
                      hintText: 'Confirm Password',
                      prefixIcon: Icons.lock_outline,
                      obscureText: _obscureConfirmPassword,
                      suffixIcon:  IconButton(
                        icon: Icon(_obscureConfirmPassword ? Icons.visibility : Icons.visibility_off),
                        onPressed: () => setState(() => _obscureConfirmPassword = !_obscureConfirmPassword),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your password';
                        }
                        if (value != _passwordController.text) {
                          return 'Passwords do not match';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 32),
                    CustomButton(
                      text: 'SIGN UP',
                      onPressed: _handleSignUp,
                      isLoading: _isLoading,
                      icon: Icons.person_add,
                    ),
                    const SizedBox(height: 16),
                    Center(
                      child: TextButton(
                        onPressed: () => Navigator.push(
                          context,
                          MaterialPageRoute(builder: (_) => const SignInScreen()),
                        ),
                        child: const Text(
                          'You already have an account? Sign in',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                    )

                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );

  }
}






















/*import 'package:flutter/material.dart';
import 'package:buildbuddyfyp/Views/Login/loginPage.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {

    final _formKey = GlobalKey<FormState>();
    final _emailController = TextEditingController();
    final _passwordController = TextEditingController();
    final _confirmPasswordController = TextEditingController();
    bool _isLoading = false;
    bool _obsurePassword = true;
    bool _obsureConfirmPassword = true;

    @override
    void dispose() {
      _emailController.dispose();
      _passwordController.dispose();
      _confirmPasswordController.dispose();
      super.dispose();
    }
    void _handleSignUp() async {
      if (_formKey.currentState?.validate() ?? false) {
        setState(() => _isLoading = true);

        // Simulate API call
        await Future.delayed(const Duration(seconds: 2));

        setState(() => _isLoading = false);
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Sign up successful!')),
          );
        }
      }
    }

    // Updated color scheme
    const Color darkBlue = Color(0xFF1A1A60);     // Deeper blue for large circles
    const Color mediumBlue = Color(0xFF3939DD);   // Lighter blue for small circle and button
    const Color lightGrey = Color(0xFFF8F8F8);    // Light grey for input fields
    const Color darkGrey = Color(0xFF2E2E2E);     // Dark grey for main text
    const Color secondaryGrey = Color(0xFF757575); // Secondary text color
    const Color royalBlue = Color(0xFF3F3FDD);    // Brighter blue for button
    const Color navyBlue = Color(0xFF0A0E55);
    const Color midnightBlue = Color(0xFF191970);
    const Color grayBlue = Color(0xFF6699CC);
    const Color moreBlue = Color(0xFF87CEEB);  // SkyBlue



    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          // Large top right circle - dark blue
          Positioned(
            top: -160,
            right: -100,
            child: Container(
              width: 330,
              height: 320,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color:Colors.blue,
              ),
            ),
          ),
          // Smaller overlapping circle - medium blue
          Positioned(
            top: 70,
            right: -70,
            child: Container(
              width: 200,
              height: 200,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: darkBlue,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 10,
                    offset: Offset(0, 4),
                  ),
                ],
              ),
            ),
          ),
          // Bottom left circle - dark blue
          Positioned(
            bottom: -160,
            left: -100,
            child: Container(
              width: 450,
              height: 350,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: darkBlue,
              ),
            ),
          ),
          // Bottom right circle - medium blue
          Positioned(
            bottom: -120,
            right: -80,
            child: Container(
              width: 250,
              height: 350,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.blue,
              ),
            ),
          ),
          // Main content
          SafeArea(
            //child:SingleChildScrollView()
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 130),
                  const Text(
                    'Sign Up',
                    style: TextStyle(
                      fontSize: 50,
                      fontWeight: FontWeight.w900,
                      color: darkBlue,
                      height: 1.2,
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    'Hello! let\'s join with us',
                    style: TextStyle(
                      fontSize: 18.5,
                      color: secondaryGrey,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  const SizedBox(height: 50),
                  _buildTextField(
                    hint: 'Email',
                    icon: Icons.mail_outline,
                    backgroundColor: lightGrey,
                    iconColor: secondaryGrey,

                  ),
                  const SizedBox(height: 16),
                  _buildTextField(
                    hint: 'Password',
                    icon: Icons.key,
                    isPassword: true,
                    backgroundColor: lightGrey,
                    iconColor: secondaryGrey,
                  ),
                  const SizedBox(height: 16),
                  _buildTextField(
                    hint: 'Confirm Password',
                    icon: Icons.key,
                    isPassword: true,
                    backgroundColor: lightGrey,
                    iconColor: secondaryGrey,
                  ),
                  const Spacer(),
                  Container(
                    width: double.infinity,
                    height: 50,
                    margin: const EdgeInsets.only(bottom: 16),
                    child: ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor:Colors.lightBlue ,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        elevation: 0,
                      ),
                      child: const Text(
                        'SIGN UP',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                  Center(
                    child: TextButton(
                      onPressed: () => Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => const SignInScreen()),
                      ),
                      child: const Text(
                        'You already have an account? Sign up',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTextField({
    required String hint,
    required IconData icon,
    required Color backgroundColor,
    required Color iconColor,
    bool isPassword = false,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(45),
        boxShadow: const [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 6,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: TextFormField(
        obscureText: isPassword,
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: TextStyle(
            color: iconColor,
            fontSize: 16,
          ),
          prefixIcon: Icon(
            icon,
            color: iconColor,
          ),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(
            vertical: 15,
            horizontal: 25,
          ),
        ),
      ),
    );
  }
}
*/






















/*// screens/sign_up_screen.dart
import 'package:flutter/material.dart';

import 'loginPage.dart';


class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            top: -100,
            right: -50,
            child: Container(
              width: 200,
              height: 200,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Color(0xFF1a237e),
              ),
            ),
          ),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const Text(
                    'Sign Up',
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF1a237e),
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Hello! let\'s join with us',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey,
                    ),
                  ),
                  const SizedBox(height: 48),
                  TextFormField(
                    decoration: InputDecoration(
                      hintText: 'Email',
                      prefixIcon: const Icon(Icons.email_outlined),
                      filled: true,
                      fillColor: Colors.grey[200],
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    obscureText: true,
                    decoration: InputDecoration(
                      hintText: 'Password',
                      prefixIcon: const Icon(Icons.lock_outline),
                      filled: true,
                      fillColor: Colors.grey[200],
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    obscureText: true,
                    decoration: InputDecoration(
                      hintText: 'Confirm Password',
                      prefixIcon: const Icon(Icons.lock_outline),
                      filled: true,
                      fillColor: Colors.grey[200],
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                  const SizedBox(height: 32),
                  ElevatedButton(
                    onPressed: () {},
                    child: const Text('SIGN UP'),
                  ),
                  const SizedBox(height: 16),
                  TextButton(
                    onPressed: () => Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => const SignInScreen()),
                    ),
                    child: const Text(
                      'You already have an account? Sign in',
                      style: TextStyle(color: Color(0xFF1a237e)),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
*/



















