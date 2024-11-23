
//Runnable code
/*
import 'package:firebase_auth/firebase_auth.dart';
import 'dart:async';
import 'package:buildbuddyfyp/Services/auth/authService.dart';
import 'package:buildbuddyfyp/Models/userModels.dart';
import 'package:flutter/foundation.dart';

class UserController {
  final AuthService _authService = AuthService();
  UserData? _currentUser;
  final _userStateController = StreamController<UserData?>.broadcast();

  // Expose user state as a stream
  Stream<UserData?> get userStream => _userStateController.stream;
  UserData? get currentUser => _currentUser;

  // Initialize controller and set up auth state listener
  void init() {
    // Listen to auth state changes
    _authService.userDataStream.listen((userData) {
      _currentUser = userData;
      _userStateController.add(userData);
    }, onError: (error) {
      if (kDebugMode) {
        print('Error in auth state stream: $error');
      }
      _userStateController.addError(error);
    });
  }

  // Login with email and password
  Future<UserLoginResponse> login(UserCredentials credentials) async {
    try {
      if (!_isValidEmail(credentials.email)) {
        return UserLoginResponse.error(
          'Invalid email format',
          'Please enter a valid email address',
        );
      }

      final response = await _authService.signInWithEmailAndPassword(credentials);
      if (response.success) {
        _currentUser = response.userData;
        _userStateController.add(_currentUser);
      }
      return response;
    } on FirebaseAuthException catch (e) {
      return _handleFirebaseAuthError(e);
    } catch (e) {
      return UserLoginResponse.error(
        'Authentication Error',
        'An unexpected error occurred during login: ${e.toString()}',
      );
    }
  }

  // Register new user with validation
  Future<UserLoginResponse> register(RegisterUserData registerData) async {
    try {
      if (!_isValidEmail(registerData.email)) {
        return UserLoginResponse.error(
          'Invalid email format',
          'Please enter a valid email address',
        );
      }

      if (!_isValidPassword(registerData.password)) {
        return UserLoginResponse.error(
          'Invalid password',
          'Password must be at least 8 characters long and contain at least one number',
        );
      }

      final response = await _authService.registerUser(registerData);
      if (response.success) {
        _currentUser = response.userData;
        _userStateController.add(_currentUser);
      }
      return response;
    } on FirebaseAuthException catch (e) {
      return _handleFirebaseAuthError(e);
    } catch (e) {
      return UserLoginResponse.error(
        'Registration Error',
        'An unexpected error occurred during registration: ${e.toString()}',
      );
    }
  }

  // Google Sign In with enhanced error handling
  Future<UserLoginResponse> signInWithGoogle(UserRole role) async {
    try {
      final response = await _authService.signInWithGoogle(role);
      if (response.success) {
        _currentUser = response.userData;
        _userStateController.add(_currentUser);
      }
      return response;
    } on FirebaseAuthException catch (e) {
      return _handleFirebaseAuthError(e);
    } catch (e) {
      return UserLoginResponse.error(
        'Google Sign-In Error',
        'An unexpected error occurred during Google sign-in: ${e.toString()}',
      );
    }
  }

  // Sign out with cleanup
  Future<void> signOut() async {
    try {
      await _authService.signOut();
      _currentUser = null;
      _userStateController.add(null);
    } catch (e) {
      throw Exception('Failed to sign out: ${e.toString()}');
    }
  }

  // Enhanced password reset with validation
  Future<Map<String, dynamic>> resetPassword(String email) async {
    try {
      if (!_isValidEmail(email)) {
        return {
          'success': false,
          'message': 'Please enter a valid email address',
          'error': 'invalid-email-format'
        };
      }

      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
      return {
        'success': true,
        'message': 'Password reset email sent successfully'
      };
    } on FirebaseAuthException catch (e) {
      return _handlePasswordResetError(e);
    } catch (e) {
      return {
        'success': false,
        'message': 'An unexpected error occurred',
        'error': e.toString()
      };
    }
  }

  // Load current user data with timeout
  Future<UserData?> loadCurrentUser({int timeoutSeconds = 10}) async {
    try {
      _currentUser = await _authService.getCurrentUserData()
          .timeout(Duration(seconds: timeoutSeconds));
      _userStateController.add(_currentUser);
      return _currentUser;
    } on TimeoutException {
      throw Exception('Failed to load user data: Request timed out');
    } catch (e) {
      throw Exception('Failed to load user data: ${e.toString()}');
    }
  }

  // Helper methods for validation
  bool _isValidEmail(String email) {
    return RegExp(r'^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+').hasMatch(email);
  }

  bool _isValidPassword(String password) {
    return password.length >= 8 && RegExp(r'[0-9]').hasMatch(password);
  }

  // Firebase Auth error handler
  UserLoginResponse _handleFirebaseAuthError(FirebaseAuthException e) {
    switch (e.code) {
      case 'user-not-found':
        return UserLoginResponse.error(
          'User Not Found',
          'No user found with this email address',
        );
      case 'wrong-password':
        return UserLoginResponse.error(
          'Invalid Password',
          'The password is invalid for this email',
        );
      case 'email-already-in-use':
        return UserLoginResponse.error(
          'Email In Use',
          'This email address is already registered',
        );
      case 'invalid-email':
        return UserLoginResponse.error(
          'Invalid Email',
          'Please enter a valid email address',
        );
      case 'weak-password':
        return UserLoginResponse.error(
          'Weak Password',
          'Please choose a stronger password',
        );
      case 'operation-not-allowed':
        return UserLoginResponse.error(
          'Operation Not Allowed',
          'This authentication method is not enabled',
        );
      default:
        return UserLoginResponse.error(
          'Authentication Error',
          'An error occurred: ${e.message}',
        );
    }
  }

  // Password reset error handler
  Map<String, dynamic> _handlePasswordResetError(FirebaseAuthException e) {
    String message;
    switch (e.code) {
      case 'invalid-email':
        message = 'The email address is not valid.';
        break;
      case 'user-not-found':
        message = 'No user found with this email address.';
        break;
      case 'too-many-requests':
        message = 'Too many password reset attempts. Please try again later.';
        break;
      default:
        message = 'An error occurred while sending password reset email.';
    }
    return {
      'success': false,
      'message': message,
      'error': e.code
    };
  }

  // Cleanup resources
  void dispose() {
    _userStateController.close();
  }
}

// Role-based access control extension
extension UserRoleExtension on UserRole {
  bool get isHomeowner => this == UserRole.homeowner;
  bool get isContractor => this == UserRole.contractor;
  bool get isArchitect => this == UserRole.architect;
  bool get isVendor => this == UserRole.vendor;
  bool get isAdmin => this == UserRole.admin;

  // Helper method to check if role has access to specific feature
  bool hasAccess(List<UserRole> allowedRoles) => allowedRoles.contains(this);
}
*/



























import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

import 'package:buildbuddyfyp/Services/auth/authService.dart';
import 'package:buildbuddyfyp/Models/userModels.dart';
import 'package:flutter/material.dart';

import '../Services/auth/authService.dart';

class AuthController extends GetxController {
  final AuthService _authService = AuthService();

  // Observable values
  final Rx<UserData?> currentUser = Rx<UserData?>(null);
  final RxBool isLoading = false.obs;
  final RxString errorMessage = ''.obs;

  @override
  void onInit() {
    super.onInit();
    // Listen to auth state changes
    _authService.userDataStream.listen((userData) {
      currentUser.value = userData;
    });
  }

  final FirebaseAuth _auth = FirebaseAuth.instance;

  /*Future<bool> signInWithEmail(String email, String password) async {
    try {
      // Sign in with Firebase Authentication
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Retrieve user data from Firestore
      DocumentSnapshot<Map<String, dynamic>> userDoc = await FirebaseFirestore
          .instance
          .collection('users')
          .doc(userCredential.user!.uid)
          .get();

      if (userDoc.exists) {
        Map<String, dynamic> data = userDoc.data()!;
        UserRole role = UserRole.values.firstWhere(
              (e) => e.toString() == 'UserRole.${data['role']}',
          orElse: () => UserRole.homeowner, // Default role if not found
        );



        // Update the current user with UserData instead of UserModel
        currentUser.value = UserData(
          uid: userCredential.user!.uid,
          email: userCredential.user!.email ?? '',
          role: role,
          displayName: data['displayName'],
          photoURL: data['photoURL'],
          phoneNumber: data['phoneNumber'],
          emailVerified: userCredential.user!.emailVerified,
          provider: userCredential.user!.providerData.first.providerId,
          createdAt: (userDoc.data()?['createdAt'] != null)
              ? DateTime.parse(data['createdAt'])
              : DateTime.now(),
          lastLogin: DateTime.now(),
          status: data['status'] ?? 'active',
        );
        return true;
      } else {
        print('User document not found for UID: ${userCredential.user!.uid}');
        return false;
      }
    } catch (e) {
      print('Error during sign-in: $e');
      return false;
    }
  }*/


  // Email Sign In
  Future<bool> signInWithEmail(String email, String password) async {
    try {
      isLoading.value = true;
      errorMessage.value = '';

      final credentials = UserCredentials(
        email: email,
        password: password,
      );

      final response = await _authService.signInWithEmailAndPassword(credentials);

      if (response.success) {
        currentUser.value = response.userData;
        return true;
      } else {
        errorMessage.value = response.message;
        return false;
      }
    } catch (e) {
      errorMessage.value = 'An unexpected error occurred';
      return false;
    } finally {
      isLoading.value = false;
    }
  }

  // Registration
  Future<bool> registerUser({
    required String email,
    required String password,
   // required String displayName,
    //required String phoneNumber,
    required UserRole role,
  }) async {
    try {
      isLoading.value = true;
      errorMessage.value = '';

      final registerData = RegisterUserData(
        email: email,
        password: password,
      //  displayName: displayName,
        //phoneNumber: phoneNumber,
        role: role,
      );

      final response = await _authService.registerUser(registerData);

      if (response.success) {
        currentUser.value = response.userData;
        Get.snackbar(
          'Success',
          response.message,
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.green,
          colorText: Colors.white,
        );
        return true;
      } else {
        errorMessage.value = response.message;
        Get.snackbar(
          'Error',
          response.message,
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
        return false;
      }
    } catch (e) {
      errorMessage.value = 'Registration failed';
      return false;
    } finally {
      isLoading.value = false;
    }
  }

  // Google Sign In
  Future<bool> signInWithGoogle(UserRole role) async {
    try {
      isLoading.value = true;
      errorMessage.value = '';

      final response = await _authService.signInWithGoogle(role);

      if (response.success) {
        currentUser.value = response.userData;
        return true;
      } else {
        errorMessage.value = response.message;
        Get.snackbar(
          'Error',
          response.message,
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
        return false;
      }
    } catch (e) {
      errorMessage.value = 'Google sign in failed';
      return false;
    } finally {
      isLoading.value = false;
    }
  }

  // Sign Out
  Future<void> signOut() async {
    try {
      isLoading.value = true;
      await _authService.signOut();
      currentUser.value = null;
      Get.offAllNamed('/login'); // Navigate to login screen
    } catch (e) {
      errorMessage.value = 'Sign out failed';
      Get.snackbar(
        'Error',
        'Failed to sign out',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } finally {
      isLoading.value = false;
    }
  }

  // Check Current User
  Future<void> checkCurrentUser() async {
    try {
      isLoading.value = true;
      final userData = await _authService.getCurrentUserData();
      currentUser.value = userData;
    } catch (e) {
      errorMessage.value = 'Failed to fetch user data';
    } finally {
      isLoading.value = false;
    }
  }

  // Helper Methods
  bool get isAuthenticated => currentUser.value != null;

  bool get isEmailVerified =>
      currentUser.value?.emailVerified ?? false;

  bool get requiresEmailVerification =>
      currentUser.value != null &&
          [UserRole.contractor, UserRole.architect, UserRole.vendor]
              .contains(currentUser.value!.role);

  // Navigation Methods
  void goToHome() {
    if (currentUser.value != null) {
      switch (currentUser.value!.role) {
        case UserRole.homeowner:
          Get.offAllNamed('/homeowner-dashboard');
          break;
        case UserRole.contractor:
          Get.offAllNamed('/contractor-dashboard');
          break;
        case UserRole.architect:
          Get.offAllNamed('/architect-dashboard');
          break;
        case UserRole.vendor:
          Get.offAllNamed('/vendor-dashboard');
          break;
        case UserRole.admin:
          Get.offAllNamed('/admin-dashboard');
          break;
        default:
          Get.offAllNamed('/login');
      }
    }
  }

  // Reset Error Message
  void clearError() {
    errorMessage.value = '';
  }
}
















































