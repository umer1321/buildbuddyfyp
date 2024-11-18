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
  }  // Register new user with validation
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










/*import 'package:firebase_auth/firebase_auth.dart';
import '../Models/userModels.dart';
import '../Services/auth/authService.dart';

class AuthController {
  final AuthService _authService = AuthService();

  // Sign in with email and password
  Future<Map<String, dynamic>> signInWithEmailAndPassword(UserCredentials credentials) async {
    try {
      final UserCredential userCredential = await _authService.signInWithEmailAndPassword(
        email: credentials.email,
        password: credentials.password,
      );
      return {
        'success': true,
        'user': userCredential.user,
        'message': 'Successfully signed in'
      };
    } on FirebaseAuthException catch (e) {
      String errorMessage;
      switch (e.code) {
        case 'user-not-found':
          errorMessage = 'No user found with this email.';
          break;
        case 'wrong-password':
          errorMessage = 'Wrong password provided.';
          break;
        case 'user-disabled':
          errorMessage = 'This account has been disabled.';
          break;
        case 'too-many-requests':
          errorMessage = 'Too many attempts. Please try again later.';
          break;
        default:
          errorMessage = 'An error occurred. Please try again.';
      }
      return {
        'success': false,
        'message': errorMessage,
        'error': e.code
      };
    } catch (e) {
      return {
        'success': false,
        'message': 'An unexpected error occurred. Please try again.',
        'error': e.toString()
      };
    }
  }

  // Create new user with email and password
  Future<Map<String, dynamic>> createUserWithEmailAndPassword(UserCredentials credentials) async {
    try {
      final UserCredential userCredential = await _authService.createUserWithEmailAndPassword(
        email: credentials.email,
        password: credentials.password,
      );
      return {
        'success': true,
        'user': userCredential.user,
        'message': 'Account created successfully'
      };
    } on FirebaseAuthException catch (e) {
      String errorMessage;
      switch (e.code) {
        case 'weak-password':
          errorMessage = 'The password provided is too weak.';
          break;
        case 'email-already-in-use':
          errorMessage = 'An account already exists for this email.';
          break;
        case 'invalid-email':
          errorMessage = 'The email address is not valid.';
          break;
        default:
          errorMessage = 'An error occurred during registration.';
      }
      return {
        'success': false,
        'message': errorMessage,
        'error': e.code
      };
    } catch (e) {
      return {
        'success': false,
        'message': 'An unexpected error occurred during registration.',
        'error': e.toString()
      };
    }
  }

  // Sign in with Google
  Future<Map<String, dynamic>> signInWithGoogle() async {
    try {
      final UserCredential userCredential = await _authService.signInWithGoogle();
      return {
        'success': true,
        'user': userCredential.user,
        'message': 'Successfully signed in with Google'
      };
    } catch (e) {
      return {
        'success': false,
        'message': 'Failed to sign in with Google. Please try again.',
        'error': e.toString()
      };
    }
  }

  // Sign out user
  Future<Map<String, dynamic>> signOut() async {
    try {
      await _authService.signOut();
      return {
        'success': true,
        'message': 'Successfully signed out'
      };
    } catch (e) {
      return {
        'success': false,
        'message': 'Failed to sign out. Please try again.',
        'error': e.toString()
      };
    }
  }

  // Get current user
  Future<Map<String, dynamic>> getCurrentUser() async {
    try {
      final User? user = _authService.getCurrentUser();
      return {
        'success': true,
        'user': user,
        'message': user != null ? 'User retrieved successfully' : 'No user logged in'
      };
    } catch (e) {
      return {
        'success': false,
        'message': 'Failed to get current user.',
        'error': e.toString()
      };
    }
  }

  // Send password reset email
  Future<Map<String, dynamic>> sendPasswordResetEmail(String email) async {
    try {
      await _authService.sendPasswordResetEmail(email);
      return {
        'success': true,
        'message': 'Password reset email sent successfully'
      };
    } on FirebaseAuthException catch (e) {
      String errorMessage;
      switch (e.code) {
        case 'invalid-email':
          errorMessage = 'The email address is not valid.';
          break;
        case 'user-not-found':
          errorMessage = 'No user found with this email.';
          break;
        default:
          errorMessage = 'Failed to send password reset email.';
      }
      return {
        'success': false,
        'message': errorMessage,
        'error': e.code
      };
    } catch (e) {
      return {
        'success': false,
        'message': 'An unexpected error occurred.',
        'error': e.toString()
      };
    }
  }
}
*/
/*import 'package:buildbuddyfyp/Services/auth/authService.dart';
import 'package:buildbuddyfyp/Models/userModels.dart';

class AuthController {
  final AuthService _authServices = AuthService();
Future<void> signInWithEmailAndPassword(UserCredentials credentials) async {
  await _authServices.signInWithEmailAndPassword(
      email:credentials.email,
      password:credentials.password,
  );
}

Future<void>signInWithGoogle() async {
  await _authServices.signInWithGoogle();
}

Future<void>createUserWithEmailAndPassword(UserCredentials credentials) async {
  await _authServices.createUserWithEmailAndPassword(
      email:credentials.email,
      password:credentials.password,
  );
}
Future<void>sendPasswordResetEmail(String email) async {
  await _authServices.sendPasswordResetEmail(email);
}

}

*/