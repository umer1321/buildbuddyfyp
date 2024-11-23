
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:buildbuddyfyp/Controllers/authControllers.dart';
import '../../Models/userModels.dart';

class HomeOwnerDashboard extends StatefulWidget {
  const HomeOwnerDashboard({super.key});

  @override
  HomeOwnerDashboardState createState() => HomeOwnerDashboardState();
}

class HomeOwnerDashboardState extends State<HomeOwnerDashboard> {
  final AuthController _authController = Get.find<AuthController>();

  @override
  void initState() {
    super.initState();
    // Any additional initialization if needed
  }

  Future<void> _handleSignOut() async {
    try {
      await _authController.signOut();
      Get.offAllNamed('/login'); // Using GetX navigation
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
            color: Color(0xFF1A1A60),
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 2,
        actions: [
          IconButton(
            icon: const Icon(Icons.logout, color: Color(0xFF1A1A60)),
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
              Card(
                elevation: 4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Welcome, ${userData.name ?? "Homeowner"}',
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF1A1A60),
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        userData.email ?? '',
                        style: const TextStyle(
                          fontSize: 16,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
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
                        () => Get.toNamed('/projects'),
                  ),
                  _buildDashboardCard(
                    'Find Professionals',
                    Icons.people,
                        () => Get.toNamed('/professionals'),
                  ),
                  _buildDashboardCard(
                    'Messages',
                    Icons.message,
                        () => Get.toNamed('/messages'),
                  ),
                  _buildDashboardCard(
                    'Settings',
                    Icons.settings,
                        () => Get.toNamed('/settings'),
                  ),
                ],
              ),
            ],
          ),
        );
      }),
    );
  }

  Widget _buildDashboardCard(String title, IconData icon, VoidCallback onTap) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 40,
              color: const Color(0xFF1A1A60),
            ),
            const SizedBox(height: 8),
            Text(
              title,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Color(0xFF1A1A60),
              ),
            ),
          ],
        ),
      ),
    );
  }
}




































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