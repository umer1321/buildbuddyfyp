import 'package:buildbuddyfyp/Views/DashBoard/HomeOwner.dart';
import 'package:flutter/material.dart';
import 'package:buildbuddyfyp/Views/Login/signUp.dart';
import 'package:buildbuddyfyp/Views/Login/forgotPassword.dart';
import '../../Models/userModels.dart';
import '../Shared/widgets/custom_button.dart';
import '../Shared/widgets/input_field.dart';
import '../../Controllers/authControllers.dart';





// Password Validator class
class PasswordValidator {
  static String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password is required';
    }
    if (value.length < 8) {
      return 'Password must be at least 8 characters long';
    }
    if (value.contains(RegExp(r'^[0-9]+$'))) {
      return 'Password cannot be entirely numeric';
    }
    if (!value.contains(RegExp(r'[A-Z]'))) {
      return 'Password must contain at least one uppercase letter';
    }
    if (!value.contains(RegExp(r'[a-z]'))) {
      return 'Password must contain at least one lowercase letter';
    }
    if (!value.contains(RegExp(r'[0-9]'))) {
      return 'Password must contain at least one number';
    }
    if (!value.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'))) {
      return 'Password must contain at least one special character';
    }
    return null;
  }
}

// Convert to StatefulWidget
class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  //late AuthController _authController;
  // Add form key and controllers
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isLoading = false;
  bool _rememberMe = false;
  bool _obscurePassword = true;
  final _authController = UserController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  // Add email validation
  String? _validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Email is required';
    }
    if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
      return 'Please enter a valid email address';
    }
    return null;
  }

  // Add sign in handler
  void _handleSignIn() async {
    if (_formKey.currentState?.validate() ?? false) {
      setState(() => _isLoading = true);

      try {
        final response = await _authController.login(
          UserCredentials(
            email: _emailController.text.trim(),
            password: _passwordController.text,
          ),
        );

        if (mounted) {
          if (response.success) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Signed in successfully!')),
            );
            // Navigate to appropriate screen based on user role
            _navigateBasedOnRole(response.userData!.role);
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(response.message)),
            );
          }
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

  /*void _handleGoogleSignIn() async {
    setState(() => _isLoading = true);

    try {
      await _authController.signInWithGoogle();

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Signed in with Google successfully!')),
        );
        // Navigate to home page
        // Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const HomePage()));
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

*/

  void _handleGoogleSignIn() async {
    // Show role selection dialog before proceeding with Google sign-in
    final selectedRole = await showDialog<UserRole>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Select Your Role'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: UserRole.values.map((role) {
              return ListTile(
                title: Text(role.name.toUpperCase()),
                onTap: () => Navigator.pop(context, role),
              );
            }).toList(),
          ),
        );
      },
    );

    if (selectedRole == null) return;

    setState(() => _isLoading = true);

    try {
      final response = await _authController.signInWithGoogle(selectedRole);

      if (mounted) {
        if (response.success) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Signed in with Google successfully!')),
          );
          _navigateBasedOnRole(response.userData!.role);
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Error: ${response.message}')),
          );
        }
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

  /*void _navigateBasedOnRole(UserRole role){

  }
*/
  void _navigateBasedOnRole(UserRole role) {
    switch (role) {
      case UserRole.homeowner:
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (_) => const HomeOwnerDashboard())
        );
        //break;
     /* case UserRole.contractor:
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (_) => Constructor())*/
       // );
        break;
    // Add cases for other roles
      default:
      // Default fallback screen if no specific role match
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (_) => const HomeOwnerDashboard())
        );
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            top: -55,
            right: -90,
            child: Container(
              width: 250,
              height: 200,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.blue,
              ),
            ),
          ),
          Positioned(
            top: -55,
            right: 50,
            child: Container(
              width: 250,
              height: 200,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Color(0xFF1a237e),
              ),
            ),
          ),
          Positioned(
            bottom: -150,
            left: -100,
            child: Container(
              width: 400,
              height: 580,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.blue,
              ),
            ),
          ),
          Positioned(
            bottom: -270,
            right: -150,
            child: Container(
              width: 700,
              height: 550,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Color(0xFF1a237e),
              ),
            ),
          ),
          SafeArea(
            child:SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                      const SizedBox(height: 60),
                  const Text(
                    'Welcome\nBack',
                    style: TextStyle(
                      fontSize: 40,
                      fontWeight: FontWeight.w900,
                      color: Color(0xFF1A1A60),
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Hey! Good to see you again',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey,
                    ),
                  ),
                  const SizedBox(height: 30),
                  InputField(
                    controller: _emailController,
                    hintText: 'Email',
                    prefixIcon: Icons.email_outlined,
                    keyboardType: TextInputType.emailAddress,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Email is required';
                      }
                      if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
                        return 'Please enter a valid email address';
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
                    //validator: PasswordValidator.validatePassword,
                    validator: PasswordValidator.validatePassword,
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Checkbox(
                            value: _rememberMe,
                            onChanged: (value) => setState(() => _rememberMe = value ?? false),
                          ),
                          const Text('Remember me'),
                        ],
                      ),
                      TextButton(
                        onPressed: () => Navigator.push(
                          context,
                          MaterialPageRoute(builder: (_) => const ForgotPasswordScreen()),
                        ),
                        child: const Text(
                          'Forgot password?',
                          style: TextStyle(color: Color(0xFF1A1A60)),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 130),
    CustomButton(
              text: 'SIGN IN',
                  onPressed: _handleSignIn,
                isLoading: _isLoading,
             icon: Icons.login,
    ),
    const SizedBox(height: 16),
           TextButton(
        onPressed: () => Navigator.pushReplacement(
    context,
                  MaterialPageRoute(builder: (_) => const SignUpScreen()),
    ), child: const Text(
             'Don\'t have an account? Sign up',
             style: TextStyle(
               color: Colors.white,
               fontSize: 16,
             ),
            ),
          ),
        ],
      ),
    ),
    ),
    ),
    ),
    ],
    ),
    );
  }
}
























/*
import 'package:flutter/material.dart';
import 'package:buildbuddyfyp/Views/Login/signUp.dart';
import 'package:buildbuddyfyp/Views/Login/loginPage.dart';
import 'package:buildbuddyfyp/Views/Login/forgotPassword.dart';

// Add Password Validator class
class PasswordValidator {
  static String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password is required';
    }
    if (value.length < 8) {
      return 'Password must be at least 8 characters long';
    }
    if (value.contains(RegExp(r'^[0-9]+$'))) {
      return 'Password cannot be entirely numeric';
    }
    if (!value.contains(RegExp(r'[A-Z]'))) {
      return 'Password must contain at least one uppercase letter';
    }
    if (!value.contains(RegExp(r'[a-z]'))) {
      return 'Password must contain at least one lowercase letter';
    }
    if (!value.contains(RegExp(r'[0-9]'))) {
      return 'Password must contain at least one number';
    }
    if (!value.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'))) {
      return 'Password must contain at least one special character';
    }
    return null;
  }
}

// Convert to StatefulWidget
class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  // Add form key and controllers
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _rememberMe = false;
  bool _obscurePassword = true;

  // Add email validation
  String? _validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Email is required';
    }
    if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
      return 'Please enter a valid email address';
    }
    return null;
  }

  // Add sign in handler
  void _handleSignIn() {
    if (_formKey.currentState?.validate() ?? false) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Processing Sign In')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            top: -55,
            right: -90,
            child: Container(
              width: 250,
              height: 200,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.blue,
              ),
            ),
          ),
          Positioned(
            top: -55,
            right: 50,
            child: Container(
              width: 250,
              height: 200,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Color(0xFF1a237e),
              ),
            ),
          ),
          Positioned(
            bottom: -150,
            left: -100,
            child: Container(
              width: 400,
              height: 580,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.blue,
              ),
            ),
          ),
          Positioned(
            bottom: -270,
            right: -150,
            child: Container(
              width: 700,
              height: 550,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Color(0xFF1a237e),
              ),
            ),
          ),
          SafeArea(
            // Wrap with Form widget
            child: Form(
              key: _formKey,
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const SizedBox(height: 60),
                    const Text(
                      'Welcome \n Back',
                      style: TextStyle(
                        fontSize: 40,
                        fontWeight: FontWeight.w900,
                        color: Color(0xFF1a237e),
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'Hey! Good to see you again',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey,
                      ),
                    ),
                    const SizedBox(height: 30),
                    // Updated email field with validation
                    TextFormField(
                      controller: _emailController,
                      validator: _validateEmail,
                      decoration: InputDecoration(
                        hintText: 'Email',
                        prefixIcon: const Icon(Icons.email_outlined),
                        filled: true,
                        fillColor: Colors.grey[200],
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide: BorderSide.none,
                        ),
                        errorStyle: const TextStyle(height: 0.8),
                        errorMaxLines: 2,
                      ),
                    ),
                    const SizedBox(height: 16),
                    // Updated password field with validation and visibility toggle
                    TextFormField(
                      controller: _passwordController,
                      validator: PasswordValidator.validatePassword,
                      obscureText: _obscurePassword,
                      decoration: InputDecoration(
                        hintText: 'Password',
                        prefixIcon: const Icon(Icons.lock_outline),
                        suffixIcon: IconButton(
                          icon: Icon(
                            _obscurePassword ? Icons.visibility : Icons.visibility_off,
                          ),
                          onPressed: () {
                            setState(() {
                              _obscurePassword = !_obscurePassword;
                            });
                          },
                        ),
                        filled: true,
                        fillColor: Colors.grey[200],
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide: BorderSide.none,
                        ),
                        errorStyle: const TextStyle(height: 0.8),
                        errorMaxLines: 3,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            // Updated checkbox with state
                            Checkbox(
                              value: _rememberMe,
                              onChanged: (value) {
                                setState(() {
                                  _rememberMe = value ?? false;
                                });
                              },
                            ),
                            const Text('Remember me'),
                          ],
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (_) => const ForgotPasswordScreen()),
                            );
                          },
                          child: const Text(
                            'Forgot password?',
                            style: TextStyle(color: Color(0xFF1a237e)),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 130),
                    ElevatedButton(
                      // Updated onPressed with validation handler
                      onPressed: _handleSignIn,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 16),
                      ),
                      child: const Text(
                        'SIGN IN',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    TextButton(
                      onPressed: () => Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => const SignUpScreen()),
                      ),
                      child: const Text(
                        'Don\'t have an account? Sign up',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Add dispose method
  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}
*/














/*// screens/sign_in_screen.dart
import 'package:flutter/material.dart';
//import 'sign_up_screen.dart';
import 'signUp.dart';

class SignInScreen extends StatelessWidget {
  const SignInScreen({super.key});

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
                    'Welcome Back',
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF1a237e),
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Hey! Good to see you again',
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Checkbox(
                            value: false,
                            onChanged: (value) {},
                          ),
                          const Text('Remember me'),
                        ],
                      ),
                      TextButton(
                        onPressed: () {},
                        child: const Text(
                          'Forgot password?',
                          style: TextStyle(color: Color(0xFF1a237e)),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 32),
                  ElevatedButton(
                    onPressed: () {},
                    child: const Text('SIGN IN'),
                  ),
                  const SizedBox(height: 16),
                  TextButton(
                    onPressed: () => Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => const SignUpScreen()),
                    ),
                    child: const Text(
                      'Don\'t have an account? Sign up',
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

































