// lib/services/auth_service.dart

import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:buildbuddyfyp/Models/userModels.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final DatabaseReference _database = FirebaseDatabase.instance.ref();

  // Sign in with email and password
  Future<UserLoginResponse> signInWithEmailAndPassword(UserCredentials credentials) async {
    try {
      final UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: credentials.email,
        password: credentials.password,
      );

      // Get user role and data
      final userData = await _getUserData(userCredential.user!.uid);
      if (userData == null) {
        return UserLoginResponse.error('User data not found');
      }

      await _updateUserLastLogin(userData);
      return UserLoginResponse.success(userData);

    } on FirebaseAuthException catch (e) {
      String message;
      switch (e.code) {
        case 'user-not-found':
          message = 'No user found with this email.';
          break;
        case 'wrong-password':
          message = 'Wrong password provided.';
          break;
        case 'user-disabled':
          message = 'This account has been disabled.';
          break;
        case 'too-many-requests':
          message = 'Too many attempts. Please try again later.';
          break;
        default:
          message = 'An error occurred. Please try again.';
      }
      return UserLoginResponse.error(message, e.code);
    }
  }

  // Register new user
  Future<UserLoginResponse> registerUser(RegisterUserData registerData) async {
    try {
      final UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
        email: registerData.email,
        password: registerData.password,
      );

      final userData = UserData(
        uid: userCredential.user!.uid,
        email: registerData.email,
        role: registerData.role,
        displayName: registerData.displayName,
        phoneNumber: registerData.phoneNumber,
        emailVerified: userCredential.user!.emailVerified,
        provider: 'password',
        createdAt: DateTime.now(),
        lastLogin: DateTime.now(),
      );

      await _createUserInDatabase(userData);
      return UserLoginResponse.success(userData);

    } on FirebaseAuthException catch (e) {
      String message;
      switch (e.code) {
        case 'weak-password':
          message = 'The password provided is too weak.';
          break;
        case 'email-already-in-use':
          message = 'An account already exists for this email.';
          break;
        case 'invalid-email':
          message = 'The email address is not valid.';
          break;
        default:
          message = 'An error occurred during registration.';
      }
      return UserLoginResponse.error(message, e.code);
    }
  }

  // Sign in with Google
  Future<UserLoginResponse> signInWithGoogle(UserRole role) async {
    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      if (googleUser == null) {
        return UserLoginResponse.error('Google sign-in was cancelled');
      }

      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final UserCredential userCredential = await _auth.signInWithCredential(credential);

      // Check if user exists
      UserData? userData = await _getUserData(userCredential.user!.uid);

      if (userData == null) {
        // Create new user
        userData = UserData(
          uid: userCredential.user!.uid,
          email: googleUser.email,
          role: role,
          displayName: googleUser.displayName,
          photoURL: googleUser.photoUrl,
          emailVerified: userCredential.user!.emailVerified,
          provider: 'google.com',
          createdAt: DateTime.now(),
          lastLogin: DateTime.now(),
        );
        await _createUserInDatabase(userData);
      } else {
        await _updateUserLastLogin(userData);
      }

      return UserLoginResponse.success(userData);
    } catch (e) {
      return UserLoginResponse.error('Failed to sign in with Google', e.toString());
    }
  }

  // Helper method to create user in database
  Future<void> _createUserInDatabase(UserData userData) async {
    await _database
        .child('user/${userData.role.name}/${userData.uid}')
        .set(userData.toJson());
  }

  // Helper method to update last login
  Future<void> _updateUserLastLogin(UserData userData) async {
    await _database
        .child('user/${userData.role.name}/${userData.uid}')
        .update({
      'lastLogin': DateTime.now().toIso8601String(),
    });
  }

  // Get user data from database
  Future<UserData?> _getUserData(String uid) async {
    for (UserRole role in UserRole.values) {
      final snapshot = await _database
          .child('user/${role.name}/$uid')
          .get();

      if (snapshot.exists) {
        return UserData.fromJson(
          uid,
          role,
          Map<String, dynamic>.from(snapshot.value as Map),
        );
      }
    }
    return null;
  }

  // Sign out
  Future<void> signOut() async {
    if (_auth.currentUser?.providerData
        .any((element) => element.providerId == 'google.com') ?? false) {
      await _googleSignIn.signOut();
    }
    await _auth.signOut();
  }

  // Get current authenticated user data
  Future<UserData?> getCurrentUserData() async {
    final user = _auth.currentUser;
    if (user != null) {
      return await _getUserData(user.uid);
    }
    return null;
  }

  // Stream of auth state changes with user data
  Stream<UserData?> get userDataStream => _auth.authStateChanges().asyncMap(
          (User? user) async {
        if (user == null) return null;
        return await _getUserData(user.uid);
      }
  );
}














/*import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  // Sign in with email and password
  Future<UserCredential> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    return await _auth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  // Create new user with email and password
  Future<UserCredential> createUserWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    return await _auth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  // Sign in with Google
  Future<UserCredential> signInWithGoogle() async {
    final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();

    if (googleUser == null) {
      throw FirebaseAuthException(
        code: 'google-sign-in-cancelled',
        message: 'Google sign-in was cancelled by the user',
      );
    }

    final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    return await _auth.signInWithCredential(credential);
  }

  // Sign out
  Future<void> signOut() async {
    if (_auth.currentUser?.providerData
        .any((element) => element.providerId == 'google.com') ?? false) {
      await _googleSignIn.signOut();
    }
    await _auth.signOut();
  }

  // Send password reset email
  Future<void> sendPasswordResetEmail(String email) async {
    await _auth.sendPasswordResetEmail(email: email);
  }

  // Get current user
  User? getCurrentUser() {
    return _auth.currentUser;
  }

  // Stream of auth state changes
  Stream<User?> get authStateChanges => _auth.authStateChanges();
}
*/

/*import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  Future<void> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    await _firebaseAuth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  Future<void> signInWithGoogle() async {
    final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
    final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;
    await _firebaseAuth.signInWithCredential(
      GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      ),
    );
  }

  Future<void> createUserWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    await _firebaseAuth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  Future<void> sendPasswordResetEmail(String email) async {
    await _firebaseAuth.sendPasswordResetEmail(email: email);
  }
}*/