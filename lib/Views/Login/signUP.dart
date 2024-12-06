import 'package:buildbuddyfyp/Views/shared/widgets/custom_button.dart';
import 'package:buildbuddyfyp/Views/Login/loginPage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../Controllers/authControllers.dart';
import '../../Models/userModels.dart';
import '../Shared/widgets/auth_success_animation.dart';
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

  late UserRole selectedRole;
  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;

  final _authController = Get.find<AuthController>();
  @override
  void initState() {
    super.initState();
    print("SignUpScreen received arguments: ${Get.arguments}");
    if (Get.arguments != null && Get.arguments is String) {
      selectedRole = UserRole.values.firstWhere(
            (e) => e.name == Get.arguments,
        orElse: () => UserRole.admin,
      );
    } else {
      selectedRole = UserRole.admin;
    }
    print("Selected Role: $selectedRole");
  }



  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

 /* void _handleSignUp() async {
    if (_formKey.currentState?.validate() ?? false) {
      // Show a toast about the selected role
      Get.snackbar(
        'Role Selected',
        'You are signing up as a ${selectedRole.name.toUpperCase()}',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.blueAccent,
        colorText: Colors.white,
        icon: Icon(Icons.info_outline, color: Colors.white),
        duration: Duration(seconds: 2),
      );

      // Register user with selected role
      final success = await _authController.registerUser(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
        role: selectedRole,
      );

      if (success) {
        _authController.goToHome();
      }
    }
  }
*/


  void _handleSignUp() async {
    if (_formKey.currentState?.validate() ?? false) {
      // Show a toast about the selected role
      Get.snackbar(
        'Role Selected',
        'You are signing up as a ${selectedRole.name.toUpperCase()}',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.blueAccent,
        colorText: Colors.white,
        icon: Icon(Icons.info_outline, color: Colors.white),
        duration: Duration(seconds: 2),
      );

      // Register user with selected role
      final success = await _authController.registerUser(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
        role: selectedRole,
      );

      if (success) {
        // Show the success animation
        await showDialog(
          context: Get.context!,
          barrierDismissible: false,
          builder: (context) => AuthSuccessAnimation(
            onAnimationComplete: () {
              Navigator.pop(context); // Close the dialog
             // _authController.goToHome(); // Navigate to home
            },
          ),
        );
      }
    }
  }

  // color scheme
  static const Color darkBlue = Color(0xFF1A1A60);     // Deeper blue for large circles
  static const Color secondaryGrey = Color(0xFF757575); // Secondary text color

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
                color: Colors.blue,
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
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(24.0),
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
                        hintText: 'Email(e.g.,umer@gmail.com)',
                        prefixIcon: Icons.mail_outline,
                        keyboardType: TextInputType.emailAddress,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your email';
                          }
                          if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
                            return 'Please enter a valid email';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 16),
                      InputField(
                        controller: _passwordController,
                        hintText: 'Password(e.g., Abx@1234)',
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
                        suffixIcon: IconButton(
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
                      const SizedBox(height: 120),
                      CustomButton(
                        text: 'SIGN UP',
                        onPressed: _handleSignUp,
                        icon: Icons.person_add,
                      ),
                      const SizedBox(height: 30),
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
                      ),
                      const SizedBox(height: 150),
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



































//Runnable code
/*import 'package:buildbuddyfyp/Views/shared/widgets/custom_button.dart';
import 'package:buildbuddyfyp/Views/Login/loginPage.dart';
import 'package:flutter/material.dart';
import '../../Controllers/authControllers.dart';
import '../../Models/userModels.dart';
import '../Shared/widgets/input_field.dart';
import 'animationScreen.dart';

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
  final _displayNameController = TextEditingController();
  final _phoneController = TextEditingController();
  UserRole selectedRole = UserRole.homeowner;
  bool _isLoading = false;
  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;
  //final _authController = UserController();
  final _authController = UserController();
  bool _showSuccessAnimation = false;


  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _displayNameController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  *//*void _handleSignUp() async {
    if (_formKey.currentState?.validate() ?? false) {
      setState(() => _isLoading = true);

      try {
        final registerData = RegisterUserData(
          email: _emailController.text.trim(),
          password: _passwordController.text.trim(),
          role: selectedRole,
        );

        final userCredentials = UserCredentials(
          email: registerData.email,
          password: registerData.password,
        );

        final response = await _authController.register(registerData);
        if (response.success) {
          // Login the user after successful registration
          final loginResponse = await _authController.login(userCredentials);
          if (loginResponse.success) {
            if (mounted) {
              // Navigate to login or home page after successful login
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (_) => const SignInScreen()),
              );
            }
          } else {
            if (mounted) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Error: ${loginResponse.message}')),
              );
            }
          }
        } else {
          if (mounted) {
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
  }*//*
  // Modify _handleSignUp method
  void _handleSignUp() async {
    if (_formKey.currentState?.validate() ?? false) {
      setState(() => _isLoading = true);

      try {
        final registerData = RegisterUserData(
          email: _emailController.text.trim(),
          password: _passwordController.text.trim(),
          role: selectedRole,
        );

        final userCredentials = UserCredentials(
          email: registerData.email,
          password: registerData.password,
        );

        final response = await _authController.register(registerData);
        if (response.success) {
          // Login the user after successful registration
          final loginResponse = await _authController.login(userCredentials);
          if (loginResponse.success) {
            if (mounted) {
              setState(() {
                _isLoading = false;
                _showSuccessAnimation = true;
              });

              // Show success animation before navigation
              await showDialog(
                context: context,
                barrierDismissible: false,
                builder: (context) => AuthSuccessAnimation(
                  onAnimationComplete: () {
                    Navigator.pop(context); // Close the dialog
                    // Navigate to login screen after animation
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (_) => const SignInScreen()),
                    );
                  },
                ),
              );
            }
          } else {
            if (mounted) {
              setState(() => _isLoading = false);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Error: ${loginResponse.message}')),
              );
            }
          }
        } else {
          if (mounted) {
            setState(() => _isLoading = false);
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Error: ${response.message}')),
            );
          }
        }
      } catch (e) {
        if (mounted) {
          setState(() => _isLoading = false);
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Error: ${e.toString()}')),
          );
        }
      }
    }
  }

  // color scheme
  static const Color darkBlue = Color(0xFF1A1A60);     // Deeper blue for large circles
  static const Color secondaryGrey = Color(0xFF757575); // Secondary text color



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
            child:SingleChildScrollView(

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

*//*
                    const SizedBox(height: 30),
                      InputField(
                        controller: _displayNameController,
                        hintText: 'Full Name',
                        prefixIcon: Icons.person_outline,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your name';
                          }
                          return null;
                        },
                      ),
                     *//*


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

*//*
                     const SizedBox(height: 16),
                      InputField(
                        controller: _phoneController,
                        hintText: 'Phone Number',
                        prefixIcon: Icons.phone_outline,
                        keyboardType: TextInputType.phone,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your phone number';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 16),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        decoration: BoxDecoration(
                          color: const Color(0xFFF8F8F8),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: DropdownButtonFormField<UserRole>(
                          value: _selectedRole,
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                            prefixIcon: Icon(Icons.work_outline),
                          ),
                          items: UserRole.values.map((role) {
                            return DropdownMenuItem(
                              value: role,
                              child: Text(role.name.toUpperCase()),
                            );
                          }).toList(),
                          onChanged: (UserRole? value) {
                            if (value != null) {
                              setState(() => _selectedRole = value);
                            }
                          },
                        ),
                      ),

                     *//**//*

                   *//*
*//*   const SizedBox(height: 16),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        decoration: BoxDecoration(
                          color: const Color(0xFFF8F8F8),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: DropdownButtonFormField<UserRole>(
                          value: _selectedRole,
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                            prefixIcon: Icon(Icons.work_outline),
                            hintText: 'Select Role',
                          ),
                          items: UserRole.values.map((role) {
                            return DropdownMenuItem(
                              value: role,
                              child: Text(role.name.toUpperCase()),
                            );
                          }).toList(),
                          onChanged: (UserRole? value) {
                            if (value != null) {
                              setState(() => _selectedRole = value);
                            }
                          },
                          validator: (value) {
                            if (value == null) {
                              return 'Please select a role';
                            }
                            return null;
                          },
                        ),
                      ),*//*





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
                      const SizedBox(height: 19),
                      CustomButton(
                        text: 'SIGN UP',
                        onPressed: _handleSignUp,
                        isLoading: _isLoading,
                        icon: Icons.person_add,
                      ),
                      const SizedBox(height: 100),
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

                      ),
                      const SizedBox(height: 150)

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
}*/

