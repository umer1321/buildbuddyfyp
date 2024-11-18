// lib/models/user_models.dart

enum UserRole {
  homeowner,
  contractor,
  architect,
  vendor,
  admin
}

class UserCredentials {
  String email;
  String password;

  UserCredentials({
    required this.email,
    required this.password
  });
}

class UserData {
  final String uid;
  final String email;
  final UserRole role;
  final String? displayName;
  final String? photoURL;
  final String? phoneNumber;
  final bool emailVerified;
  final String provider;
  final DateTime createdAt;
  final DateTime lastLogin;

  UserData({
    required this.uid,
    required this.email,
    required this.role,
    this.displayName,
    this.photoURL,
    this.phoneNumber,
    required this.emailVerified,
    required this.provider,
    required this.createdAt,
    required this.lastLogin,
  });

  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'displayName': displayName ?? '',
      'photoURL': photoURL ?? '',
      'phoneNumber': phoneNumber ?? '',
      'emailVerified': emailVerified,
      'provider': provider,
      'createdAt': createdAt.toIso8601String(),
      'lastLogin': lastLogin.toIso8601String(),
    };
  }

  factory UserData.fromJson(String uid, UserRole role, Map<String, dynamic> json) {
    return UserData(
      uid: uid,
      email: json['email'] ?? '',
      role: role,
      displayName: json['displayName'],
      photoURL: json['photoURL'],
      phoneNumber: json['phoneNumber'],
      emailVerified: json['emailVerified'] ?? false,
      provider: json['provider'] ?? '',
      createdAt: DateTime.parse(json['createdAt'] ?? DateTime.now().toIso8601String()),
      lastLogin: DateTime.parse(json['lastLogin'] ?? DateTime.now().toIso8601String()),
    );
  }

  get name => null;

  // Create a copy of UserData with updated fields
  UserData copyWith({
    String? displayName,
    String? photoURL,
    String? phoneNumber,
    DateTime? lastLogin,
  }) {
    return UserData(
      uid: uid,
      email: email,
      role: role,
      displayName: displayName ?? this.displayName,
      photoURL: photoURL ?? this.photoURL,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      emailVerified: emailVerified,
      provider: provider,
      createdAt: createdAt,
      lastLogin: lastLogin ?? this.lastLogin,
    );
  }
}

class RegisterUserData {
  final String email;
  final String password;
  final UserRole role;
  final String? displayName;
  final String? phoneNumber;

  RegisterUserData({
    required this.email,
    required this.password,
    required this.role,
    this.displayName,
    this.phoneNumber,
  });
}

class UserLoginResponse {
  final bool success;
  final UserData? userData;
  final String message;
  final String? error;

  UserLoginResponse({
    required this.success,
    this.userData,
    required this.message,
    this.error,
  });

  factory UserLoginResponse.success(UserData userData) {
    return UserLoginResponse(
      success: true,
      userData: userData,
      message: 'Login successful',
    );
  }

  factory UserLoginResponse.error(String message, [String? error]) {
    return UserLoginResponse(
      success: false,
      message: message,
      error: error,
    );
  }
}
















/*class UserCredentials {
  String email;
  String password;

  UserCredentials({
    required this.email,
    required this.password
  });
}*/