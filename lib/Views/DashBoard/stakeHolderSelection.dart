/*import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:buildbuddyfyp/Views/Login/signUP.dart';

import 'package:buildbuddyfyp/Views/DashBoard/HomeOwner.dart';
import 'package:buildbuddyfyp/Views/DashBoard/Constructor.dart';
import 'package:buildbuddyfyp/Views/DashBoard/Architect.dart';
import 'package:buildbuddyfyp/Views/DashBoard/Vendor.dart';
import 'package:buildbuddyfyp/Views/DashBoard/Admin.dart';
import 'package:buildbuddyfyp/Views/Login/loginPage.dart';




enum UserRole { homeowner, contractor, architect, vendor, admin }

class StakeholderSelection extends StatefulWidget {
  final Function(UserRole)? onRoleSelected;

  const StakeholderSelection({
    super.key,
    this.onRoleSelected,
  });

  @override
  State<StakeholderSelection> createState() => _StakeholderSelectionState();
}

class _StakeholderSelectionState extends State<StakeholderSelection> {
  final List<Map<String, dynamic>> stakeholders = const [
    {
      'role': UserRole.homeowner,
      'title': 'Homeowner',
      'icon': Icons.home,
      'description': 'Manage and oversee your home construction project',
    },
    {
      'role': UserRole.contractor,
      'title': 'Contractor',
      'icon': Icons.construction,
      'description': 'Execute and manage construction work',
    },
    {
      'role': UserRole.architect,
      'title': 'Architect',
      'icon': Icons.architecture,
      'description': 'Provide plans and design consultation',
    },
    {
      'role': UserRole.vendor,
      'title': 'Vendor',
      'icon': Icons.local_shipping,
      'description': 'Supply construction materials and resources',
    },
    {
      'role': UserRole.admin,
      'title': 'Admin',
      'icon': Icons.admin_panel_settings,
      'description': 'Manage platform and maintain system operations',
    },
  ];

  Future<void> _registerUser(String email, String password, UserRole role) async {
    try {
      // Register user
      final userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Save role in Firestore
      await FirebaseFirestore.instance
          .collection('users')
          .doc(userCredential.user!.uid)
          .set({
        'email': email,
        'role': role.name, // Save role as a string
      });

      print("User registered successfully!");
    } catch (e) {
      print("Error during registration: $e");
    }
  }

  Future<UserRole?> _fetchUserRole(String userId) async {
    try {
      final doc = await FirebaseFirestore.instance.collection('users').doc(userId).get();
      if (doc.exists) {
        final roleString = doc.data()?['role'];
        return UserRole.values.firstWhere((e) => e.name == roleString);
      }
    } catch (e) {
      print("Error fetching user role: $e");
    }
    return null;
  }

  Future<void> _handleLogin(String email, String password) async {
    try {
      final userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      final role = await _fetchUserRole(userCredential.user!.uid);

      if (role != null) {
        switch (role) {
          case UserRole.homeowner:
            Get.off(() => const HomeOwnerDashboard());
            break;
          case UserRole.contractor:
            Get.off(() => const ContractorDashboard());
            break;
          case UserRole.architect:
            Get.off(() => const ArchitectDashboard());
            break;
          case UserRole.vendor:
            Get.off(() => const VendorDashboard());
            break;
          case UserRole.admin:
            Get.off(() => const AdminDashboard());
            break;
        }
      } else {
        print("User role not found!");
      }
    } catch (e) {
      print("Login error: $e");
    }
  }

  void _handleStakeholderTap(BuildContext context, UserRole role) {
    if (widget.onRoleSelected != null) {
      widget.onRoleSelected!(role);
    }
    Get.toNamed(
      '/get-started',
      arguments: role.name,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Image.asset(
            'assets/logo.png', // Replace with your logo path
            height: 40,
          ),
        ),
      ),
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              const SizedBox(height: 24),
              Text(
                'Welcome to Build Buddy',
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: Colors.blueAccent,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Select your role to continue',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: Colors.grey[600],
                ),
              ),
              const SizedBox(height: 32),
              Expanded(
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 0.85,
                    crossAxisSpacing: 16,
                    mainAxisSpacing: 16,
                  ),
                  itemCount: stakeholders.length,
                  itemBuilder: (context, index) {
                    final stakeholder = stakeholders[index];
                    return _StakeholderCard(
                      icon: stakeholder['icon'] as IconData,
                      title: stakeholder['title'] as String,
                      description: stakeholder['description'] as String,
                      onTap: () => _handleStakeholderTap(
                        context,
                        stakeholder['role'] as UserRole,
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _StakeholderCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String description;
  final VoidCallback onTap;

  const _StakeholderCard({
    super.key,
    required this.icon,
    required this.title,
    required this.description,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      color: Colors.white,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(15),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                size: 50,
                color: Colors.blueAccent,
              ),
              const SizedBox(height: 12),
              Text(
                title,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                description,
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey[600],
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
*/



import 'package:flutter/material.dart';
import 'package:buildbuddyfyp/Models/userModels.dart';
import 'package:buildbuddyfyp/Views/Login/startedScreen.dart';
import 'package:get/get.dart';

import '../Login/signUP.dart';

class StakeholderSelection extends StatefulWidget {
  final Function(UserRole)? onRoleSelected;

  const StakeholderSelection({
    super.key,
    this.onRoleSelected,
  });

  @override
  State<StakeholderSelection> createState() => _StakeholderSelectionState();
}

class _StakeholderSelectionState extends State<StakeholderSelection> {
  final List<Map<String, dynamic>> stakeholders = const [
    {
      'role': UserRole.homeowner,
      'title': 'Homeowner',
      'icon': Icons.home,
      'description': 'Manage and oversee your home construction project',
    },
    {
      'role': UserRole.contractor,
      'title': 'Contractor',
      'icon': Icons.construction,
      'description': 'Execute and manage construction work',
    },
    {
      'role': UserRole.architect,
      'title': 'Architect',
      'icon': Icons.architecture,
      'description': 'Provide plans and design consultation',
    },
    {
      'role': UserRole.vendor,
      'title': 'Vendor',
      'icon': Icons.local_shipping,
      'description': 'Supply construction materials and resources',
    },
    {
      'role': UserRole.admin,
      'title': 'Admin',
      'icon': Icons.admin_panel_settings,
      'description': 'Manage platform and maintain system operations',
    },
  ];



  void _handleStakeholderTap(BuildContext context, UserRole role) async {
    // Notify parent about role selection (optional)
    if (widget.onRoleSelected != null) {
      widget.onRoleSelected!(role);
    }

    // Navigate to GetStartedScreen with the selected role using Get.toNamed
    Get.toNamed(
      '/get-started',
      arguments: role.name,
    );
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Image.asset(
            'assets/logo.png', // Replace with your logo path
            height: 40,
          ),
        ),
      ),
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              const SizedBox(height: 24),
              Text(
                'Welcome to Build Buddy',
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: Colors.blueAccent,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Select your role to continue',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: Colors.grey[600],
                ),
              ),
              const SizedBox(height: 32),
              Expanded(
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 0.85,
                    crossAxisSpacing: 16,
                    mainAxisSpacing: 16,
                  ),
                  itemCount: stakeholders.length,
                  itemBuilder: (context, index) {
                    final stakeholder = stakeholders[index];
                    return _StakeholderCard(
                      icon: stakeholder['icon'] as IconData,
                      title: stakeholder['title'] as String,
                      description: stakeholder['description'] as String,
                      onTap: () => _handleStakeholderTap(
                        context,
                        stakeholder['role'] as UserRole,
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _StakeholderCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String description;
  final VoidCallback onTap;

  const _StakeholderCard({
    super.key,
    required this.icon,
    required this.title,
    required this.description,
    required this.onTap,
  });

  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      color: Colors.white,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(15),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                size: 50,
                color: Colors.blueAccent,
              ),
              const SizedBox(height: 12),
              Text(
                title,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                description,
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey[600],
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
























/*
//Runnable code
import 'package:flutter/material.dart';
import 'package:buildbuddyfyp/Models/userModels.dart';
//import 'package:buildbuddyfyp/Views/GetStarted/getStartedScreen.dart'; // Updated import
import 'package:buildbuddyfyp/Views/Login/startedScreen.dart';

class StakeholderSelection extends StatefulWidget {
  final Function(UserRole)? onRoleSelected;

  const StakeholderSelection({
    super.key,
    this.onRoleSelected,
  });

  @override
  State<StakeholderSelection> createState() => _StakeholderSelectionState();
}

class _StakeholderSelectionState extends State<StakeholderSelection> {
  final List<Map<String, dynamic>> stakeholders = const [
    {
      'role': UserRole.homeowner,
      'title': 'Homeowner',
      'icon': Icons.home,
      'description': 'Manage and oversee your home construction project',
    },
    {
      'role': UserRole.contractor,
      'title': 'Contractor',
      'icon': Icons.construction,
      'description': 'Execute and manage construction work',
    },
    {
      'role': UserRole.architect,
      'title': 'Architect',
      'icon': Icons.architecture,
      'description': 'Provide plans and design consultation',
    },
    {
      'role': UserRole.vendor,
      'title': 'Vendor',
      'icon': Icons.local_shipping,
      'description': 'Supply construction materials and resources',
    },
    {
      'role': UserRole.admin,
      'title': 'Admin',
      'icon': Icons.admin_panel_settings,
      'description': 'Manage platform and maintain system operations',
    },
  ];

  void _handleStakeholderTap(BuildContext context, UserRole role) async {
    // Notify parent about role selection
    if (widget.onRoleSelected != null) {
      widget.onRoleSelected!(role);
    }

    // Navigate to GetStartedScreen
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => const GetStartedScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              const SizedBox(height: 24),
              Text(
                'Welcome to Build Buddy',
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Select your role to continue',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: Colors.grey[600],
                ),
              ),
              const SizedBox(height: 32),
              Expanded(
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 0.85,
                    crossAxisSpacing: 16,
                    mainAxisSpacing: 16,
                  ),
                  itemCount: stakeholders.length,
                  itemBuilder: (context, index) {
                    final stakeholder = stakeholders[index];
                    return _StakeholderCard(
                      icon: stakeholder['icon'] as IconData,
                      title: stakeholder['title'] as String,
                      description: stakeholder['description'] as String,
                      onTap: () => _handleStakeholderTap(
                        context,
                        stakeholder['role'] as UserRole,
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _StakeholderCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String description;
  final VoidCallback onTap;

  const _StakeholderCard({
    super.key,
    required this.icon,
    required this.title,
    required this.description,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.blue.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  icon,
                  size: 32,
                  color: Colors.blue,
                ),
              ),
              const SizedBox(height: 16),
              Text(
                title,
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
              Text(
                description,
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: Colors.grey[600],
                ),
                textAlign: TextAlign.center,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
*/
////





