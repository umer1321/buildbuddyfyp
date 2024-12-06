import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:buildbuddyfyp/Controllers/authControllers.dart';

class HomeOwnerDashboard extends StatefulWidget {
  const HomeOwnerDashboard({super.key});

  @override
  HomeOwnerDashboardState createState() => HomeOwnerDashboardState();
}

class HomeOwnerDashboardState extends State<HomeOwnerDashboard> {
  final AuthController _authController = Get.find<AuthController>();

  Future<void> _handleSignOut() async {
    try {
      await _authController.signOut();
      Get.offAllNamed('/stakeholder'); // Redirect to stakeholder selection screen
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to sign out: ${e.toString()}',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Homeowner Dashboard',
          style: TextStyle(
            color: Colors.black87,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: const Color(0xFFE3F2FD),
        elevation: 5,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black87),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications, color: Colors.black87),
            onPressed: () => Get.toNamed('/notifications'),
          ),
          IconButton(
            icon: const Icon(Icons.logout, color: Colors.black87),
            onPressed: _handleSignOut,
          ),
        ],
      ),
      body: Obx(() {
        final userData = _authController.currentUser.value;

        if (userData == null) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        return SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildWelcomeCard(userData),
              const SizedBox(height: 24),
              GridView.count(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                crossAxisCount: 2,
                mainAxisSpacing: 16,
                crossAxisSpacing: 16,
                children: [
                  _buildDashboardCard(
                    'My Projects',
                    Icons.construction,
                        () => Get.toNamed('/my-projects'),
                    const Color(0xFF81C784),
                  ),
                  _buildDashboardCard(
                    'Find Professionals',
                    Icons.people,
                        () => Get.toNamed('/find-professionals'),
                    const Color(0xFF4FC3F7),
                  ),
                  _buildDashboardCard(
                    'Messages',
                    Icons.message,
                        () => Get.toNamed('/messages'),
                    const Color(0xFFFFB74D),
                  ),
                  _buildDashboardCard(
                    'Settings',
                    Icons.settings,
                        () => Get.toNamed('/settings'),
                    const Color(0xFFF06292),
                  ),
                  _buildDashboardCard(
                    'Payments & Invoices',
                    Icons.attach_money,
                        () => Get.toNamed('/payments'),
                    const Color(0xFF9575CD),
                  ),
                  _buildDashboardCard(
                    'Rate & Review',
                    Icons.star,
                        () => Get.toNamed('/rate-review'),
                    const Color(0xFFFF8A65),
                  ),
                  _buildDashboardCard(
                    'Help & Support',
                    Icons.help_outline,
                        () => Get.toNamed('/support'),
                    const Color(0xFF64B5F6),
                  ),
                  _buildDashboardCard(
                    'Notifications',
                    Icons.notifications,
                        () => Get.toNamed('/notifications'),
                    const Color(0xFF90CAF9),
                  ),
                ],
              ),
            ],
          ),
        );
      }),
    );
  }

  Widget _buildWelcomeCard(userData) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        gradient: const LinearGradient(
          colors: [Color(0xFFE3F2FD), Color(0xFF81D4FA)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Welcome, ${userData.name ?? "Homeowner"}',
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            userData.email ?? '',
            style: const TextStyle(
              fontSize: 16,
              color: Colors.black54,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDashboardCard(
      String title, IconData icon, VoidCallback onTap, Color color) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(15),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: color,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 6,
              offset: const Offset(2, 4),
            ),
          ],
        ),
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 40,
              color: Colors.white,
            ),
            const SizedBox(height: 8),
            Text(
              title,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}










/*import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:buildbuddyfyp/Controllers/authControllers.dart';

class HomeOwnerDashboard extends StatefulWidget {
  const HomeOwnerDashboard({super.key});

  @override
  HomeOwnerDashboardState createState() => HomeOwnerDashboardState();
}

class HomeOwnerDashboardState extends State<HomeOwnerDashboard> {
  final AuthController _authController = Get.find<AuthController>();

  Future<void> _handleSignOut() async {
    try {
      await _authController.signOut();
      Get.offAllNamed('/stakeholder'); // Redirect to stakeholder selection screen
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to sign out: ${e.toString()}',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Homeowner Dashboard',
          style: TextStyle(
            color: Colors.black87,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: const Color(0xFFE3F2FD), // Light blue background
        elevation: 5,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black87),
          onPressed: () {
            Navigator.pop(context); // Go back to the previous screen
          },
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout, color: Colors.black87),
            onPressed: _handleSignOut,
          ),
        ],
      ),
      body: Obx(() {
        final userData = _authController.currentUser.value;

        if (userData == null) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        return SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Welcome Card with Gradient Background
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  gradient: const LinearGradient(
                    colors: [Color(0xFFE3F2FD), Color(0xFF81D4FA)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Welcome, ${userData.name ?? "Homeowner"}',
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      userData.email ?? '',
                      style: const TextStyle(
                        fontSize: 16,
                        color: Colors.black54,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              // Dashboard Grid
              GridView.count(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                crossAxisCount: 2,
                mainAxisSpacing: 16,
                crossAxisSpacing: 16,
                children: [
                  _buildDashboardCard(
                    'My Projects',
                    Icons.construction,
                        () => Get.toNamed('/my-projects'),
                    const Color(0xFF81C784), // Light green
                  ),
                  _buildDashboardCard(
                    'Find Professionals',
                    Icons.people,
                        () => Get.toNamed('/find-professionals'),
                    const Color(0xFF4FC3F7), // Light blue
                  ),
                  _buildDashboardCard(
                    'Messages',
                    Icons.message,
                        () => Get.toNamed('/messages'),
                    const Color(0xFFFFB74D), // Light orange
                  ),
                  _buildDashboardCard(
                    'Settings',
                    Icons.settings,
                        () => Get.toNamed('/settings'),
                    const Color(0xFFF06292), // Light pink
                  ),
                ],
              ),
            ],
          ),
        );
      }),
    );
  }

  Widget _buildDashboardCard(
      String title, IconData icon, VoidCallback onTap, Color color) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(15),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: color,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 6,
              offset: const Offset(2, 4),
            ),
          ],
        ),
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 40,
              color: Colors.white,
            ),
            const SizedBox(height: 8),
            Text(
              title,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}*/















/*
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:buildbuddyfyp/Controllers/authControllers.dart';

class HomeOwnerDashboard extends StatefulWidget {
  const HomeOwnerDashboard({super.key});

  @override
  HomeOwnerDashboardState createState() => HomeOwnerDashboardState();
}

class HomeOwnerDashboardState extends State<HomeOwnerDashboard> {
  final AuthController _authController = Get.find<AuthController>();

  Future<void> _handleSignOut() async {
    try {
      await _authController.signOut();
      Get.offAllNamed('/sign-in'); // Using GetX navigation to login screen
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to sign out: ${e.toString()}',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Homeowner Dashboard',
          style: TextStyle(
            color: Colors.black87,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: const Color(0xFFE3F2FD), // Light blue background
        elevation: 5,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black87),
          onPressed: () {
            Navigator.pop(context); // Go back to the previous screen
          },
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout, color: Colors.black87),
            onPressed: _handleSignOut,
          ),
        ],
      ),
      body: Obx(() {
        final userData = _authController.currentUser.value;

        if (userData == null) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        return SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Welcome Card with Gradient Background (Light Colors)
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  gradient: const LinearGradient(
                    colors: [Color(0xFFE3F2FD), Color(0xFF81D4FA)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Welcome, ${userData.name ?? "Homeowner"}',
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      userData.email ?? '',
                      style: const TextStyle(
                        fontSize: 16,
                        color: Colors.black54,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              // Dashboard Grid
              GridView.count(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                crossAxisCount: 2,
                mainAxisSpacing: 16,
                crossAxisSpacing: 16,
                children: [
                  _buildDashboardCard(
                    'My Projects',
                    Icons.construction,
                        () => Get.toNamed('/my-projects'), // Navigate to the 'projects' screen
                    const Color(0xFF81C784), // Light green
                  ),
                  _buildDashboardCard(
                    'Find Professionals',
                    Icons.people,
                        () => Get.toNamed('/find-professionals'), // Navigate to the 'professionals' screen
                    const Color(0xFF4FC3F7), // Light blue
                  ),
                  _buildDashboardCard(
                    'Messages',
                    Icons.message,
                        () => Get.toNamed('/messages'), // Navigate to the 'messages' screen
                    const Color(0xFFFFB74D), // Light orange
                  ),
                  _buildDashboardCard(
                    'Settings',
                    Icons.settings,
                        () => Get.toNamed('/settings'), // Navigate to the 'settings' screen
                    const Color(0xFFF06292), // Light pink
                  ),
                ],
              ),
            ],
          ),
        );
      }),
    );
  }

  Widget _buildDashboardCard(
      String title, IconData icon, VoidCallback onTap, Color color) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(15),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: color,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 6,
              offset: const Offset(2, 4),
            ),
          ],
        ),
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 40,
              color: Colors.white,
            ),
            const SizedBox(height: 8),
            Text(
              title,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}


*/


















































/*
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:buildbuddyfyp/Controllers/authControllers.dart';


class HomeOwnerDashboard extends StatefulWidget {
  const HomeOwnerDashboard({super.key});

  @override
  HomeOwnerDashboardState createState() => HomeOwnerDashboardState();
}

class HomeOwnerDashboardState extends State<HomeOwnerDashboard> {
  final AuthController _authController = Get.find<AuthController>();

  Future<void> _handleSignOut() async {
    try {
      await _authController.signOut();
      Get.offAllNamed('/sign-in'); // Using GetX navigation to login screen
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to sign out: ${e.toString()}',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Homeowner Dashboard',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: const Color(0xFF1A1A60),
        elevation: 5,
        actions: [
          IconButton(
            icon: const Icon(Icons.logout, color: Colors.white),
            onPressed: _handleSignOut,
          )
        ],
      ),
      body: Obx(() {
        final userData = _authController.currentUser.value;

        if (userData == null) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        return SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Welcome Card with Gradient Background
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  gradient: const LinearGradient(
                    colors: [Color(0xFF1A1A60), Color(0xFF4A90E2)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Welcome, ${userData.name ?? "Homeowner"}',
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      userData.email ?? '',
                      style: const TextStyle(
                        fontSize: 16,
                        color: Colors.white70,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              // Dashboard Grid
              GridView.count(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                crossAxisCount: 2,
                mainAxisSpacing: 16,
                crossAxisSpacing: 16,
                children: [
                  _buildDashboardCard(
                    'My Projects',
                    Icons.construction,
                        () => Get.toNamed('/my-projects'),  // Navigate to the 'projects' screen
                    const Color(0xFF4CAF50),
                  ),
                  _buildDashboardCard(
                    'Find Professionals',
                    Icons.people,
                        () => Get.toNamed('/find-professionals'),  // Navigate to the 'professionals' screen
                    const Color(0xFF2196F3),
                  ),
                  _buildDashboardCard(
                    'Messages',
                    Icons.message,
                        () => Get.toNamed('/messages'),  // Navigate to the 'messages' screen
                    const Color(0xFFFF9800),
                  ),
                  _buildDashboardCard(
                    'Settings',
                    Icons.settings,
                        () => Get.toNamed('/settings'),  // Navigate to the 'settings' screen
                    const Color(0xFFF44336),
                  ),
                ],
              ),
            ],
          ),
        );
      }),
    );
  }

  Widget _buildDashboardCard(
      String title, IconData icon, VoidCallback onTap, Color color) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(15),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: color,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              blurRadius: 8,
              offset: const Offset(2, 4),
            ),
          ],
        ),
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 40,
              color: Colors.white,
            ),
            const SizedBox(height: 8),
            Text(
              title,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

*/





















































/*import 'package:flutter/material.dart';
import 'package:buildbuddyfyp/Controllers/authControllers.dart';

import '../../Models/userModels.dart';

class HomeOwnerDashboard extends StatefulWidget {
  const HomeOwnerDashboard({super.key});

  @override
  HomeOwnerDashboardState createState() => HomeOwnerDashboardState();
}

class HomeOwnerDashboardState extends State<HomeOwnerDashboard> {
  final AuthController _userController = AuthController();

  @override
  void initState() {
    super.initState();
    _userController.isAuthenticated;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Homeowner Dashboard'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () async {
              await _userController.signOut();
              Navigator.of(context).pushReplacementNamed('/login');
            },
          )
        ],
      ),
      body: Column(
        children: [
          const SizedBox(height: 20),
          StreamBuilder<UserData?>(
           // stream: _userController.userStream,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const CircularProgressIndicator();
              }

              final userData = snapshot.data;
              return userData != null
                  ? Text('Welcome, ${userData.name ??"Homeowner"}')
                  : const Text('Welcome');
            }, stream: null,
          ),
          const Expanded(
            child: Center(
              child: Text('Homeowner Dashboard Content'),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _userController.dispose();
    super.dispose();
  }
}
*/