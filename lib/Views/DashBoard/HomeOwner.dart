import 'package:flutter/material.dart';
import 'package:buildbuddyfyp/Controllers/authControllers.dart';

import '../../Models/userModels.dart';

class HomeOwnerDashboard extends StatefulWidget {
  const HomeOwnerDashboard({super.key});

  @override
  HomeOwnerDashboardState createState() => HomeOwnerDashboardState();
}

class HomeOwnerDashboardState extends State<HomeOwnerDashboard> {
  final UserController _userController = UserController();

  @override
  void initState() {
    super.initState();
    _userController.init();
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
            stream: _userController.userStream,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const CircularProgressIndicator();
              }

              final userData = snapshot.data;
              return userData != null
                  ? Text('Welcome, ${userData.name ?? "Homeowner"}')
                  : const Text('Welcome');
            },
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