

import 'package:firebase_auth/firebase_auth.dart';
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