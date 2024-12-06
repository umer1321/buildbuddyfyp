import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:buildbuddyfyp/Views/Login/startedScreen.dart';
import 'package:buildbuddyfyp/Views/DashBoard/Contractor/ManageProjects.dart';
import 'package:buildbuddyfyp/Views/DashBoard/Contractor/MaterialOrders.dart';
import 'package:buildbuddyfyp/Views/DashBoard/Contractor/Messages.dart';
import 'package:buildbuddyfyp/Views/DashBoard/Contractor/Payments.dart';
import 'package:buildbuddyfyp/Views/DashBoard/Contractor/RatingAndReviews.dart';
import 'package:buildbuddyfyp/Controllers/authControllers.dart';


class ContractorDashboard extends StatefulWidget {
  const ContractorDashboard({super.key});

  @override
  ContractorDashboardState createState() => ContractorDashboardState();
}

class ContractorDashboardState extends State<ContractorDashboard> {
  final AuthController _authController = Get.find<AuthController>();

  Future<void> _handleSignOut() async {
    try {
      await _authController.signOut();
      Get.offAllNamed('/stakeholder');
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
          'Contractor Dashboard',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
        ),
        backgroundColor: const Color(0xFFE1F5FE),
        elevation: 5,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black87),
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const GetStartedScreen()),
            );
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
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  gradient: const LinearGradient(
                    colors: [Color(0xFFE1F5FE), Color(0xFF81D4FA)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      //'Welcome, ${userData.name}!',
                      'Welcome, ${userData.name ?? 'User'}!',

                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'Here’s an overview of your activities:',
                      style: TextStyle(fontSize: 16, color: Colors.black54),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              GridView.count(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                crossAxisCount: 2,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                children: [
                  _buildDashboardCard(
                    'Manage Projects',
                    Icons.construction,
                        () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ManageProjectsScreen()),
                      );
                    },
                    Colors.orange,
                  ),
                  _buildDashboardCard(
                    'Material Orders',
                    Icons.inventory,
                        () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => MaterialOrdersScreen()),
                      );
                    },
                    Colors.green,
                  ),
                  _buildDashboardCard(
                    'Messages',
                    Icons.message,
                        () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => MessagesScreen()),
                      );
                    },
                    Colors.purple,
                  ),
                  _buildDashboardCard(
                    'Payments',
                    Icons.payment,
                        () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => PaymentsScreen()),
                      );
                    },
                    Colors.teal,
                  ),
                  _buildDashboardCard(
                    'Ratings & Reviews',
                    Icons.star,
                        () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => RatingsReviewsScreen()),
                      );
                    },
                    Colors.amber,
                  ),
                ],
              )
            ],
          ),
        );
      }),
    );
  }

  Widget _buildDashboardCard(String title, IconData icon, VoidCallback onTap, Color color) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(15),
      child: Container(
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 48, color: Colors.white),
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

















/*
import 'package:flutter/material.dart';
import 'package:buildbuddyfyp/Views/Login/startedScreen.dart';
import 'package:buildbuddyfyp/Views/DashBoard/Contractor/ManageProjects.dart';
import 'package:buildbuddyfyp/Views/DashBoard/Contractor/MaterialOrders.dart';
import 'package:buildbuddyfyp/Views/DashBoard/Contractor/Messages.dart';
import 'package:buildbuddyfyp/Views/DashBoard/Contractor/Payments.dart';
import 'package:buildbuddyfyp/Views/DashBoard/Contractor/RatingAndReviews.dart';
import 'package:buildbuddyfyp/Controllers/authControllers.dart';
import 'package:get/get.dart';

class ContractorDashboard extends StatelessWidget {
  const ContractorDashboard({super.key});

  @override
  ContractorDashboardState createState() => ContractorDashboardState();


}
class ContractorDashboardState extends State<ContractorDashboard> {
  final AuthController _authController = Get.find<AuthController>();
  Future<void> _handleSignOut() async {
    try {
      await _authController.signOut();
      Get.offAllNamed('/stakeholder-selection'); // Redirect to stakeholder selection screen
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
        title: const Text('Contractor Dashboard',
          style: TextStyle(fontWeight: FontWeight.bold,
          color: Colors.black,
          ),

        ),
        backgroundColor: const Color(0xFFE1F5FE),
        elevation: 5,
        //centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back,color: Colors.black87),
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (context) => const GetStartedScreen()),
            );
          },
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout,color: Colors.black87),
            onPressed: _handleSignOut,
          ),
        ],
      ),

      body:Obx((){
        final userData = _authController.userData.value;
        if (userData == null) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              gradient: BorderRadius.circular(15),
              gradient: LinearGradient(
                colors: [Color(0xFFE1F5FE),  Color(0xFF81D4FA)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Welcome, ${userData['name']}!',
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Here’s an overview of your activities:',
                  style: const TextStyle(fontSize: 16, color: Colors.black54,
                  ),
                ),
              ],
            ),

          ),
          const SizedBox(height: 24),
          GridView.count(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            crossAxisCount: 2,
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
            children: [
              _buildDashboardCard(
                context,
                title: 'Manage Projects',
                icon: Icons.construction,
                color: Colors.orange,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>  ManageProjectsScreen()),
                  );
                },
              ),
              _buildDashboardCard(
                context,
                title: 'Material Orders',
                icon: Icons.inventory,
                color: Colors.green,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>  MaterialOrdersScreen()),
                  );
                },
              ),
              _buildDashboardCard(
                context,
                title: 'Messages',
                icon: Icons.message,
                color: Colors.purple,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>  MessagesScreen()),
                  );
                },
              ),
              _buildDashboardCard(
                context,
                title: 'Payments',
                icon: Icons.payment,
                color: Colors.teal,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>  PaymentsScreen()),
                  );
                },
              ),
              _buildDashboardCard(
                context,
                title: 'Ratings & Reviews',
                icon: Icons.star,
                color: Colors.amber,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>  RatingsReviewsScreen()),
                  );
                },
              ),
            ],

          )
        ],
        ,
      ),
    )
      })
    );
  }


     *//* body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: GridView.count(
          crossAxisCount: 2,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
          children: [
            _buildDashboardCard(
              context,
              title: 'Manage Projects',
              icon: Icons.construction,
              color: Colors.orange,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>  ManageProjectsScreen()),
                );
              },
            ),
            _buildDashboardCard(
              context,
              title: 'Material Orders',
              icon: Icons.inventory,
              color: Colors.green,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>  MaterialOrdersScreen()),
                );
              },
            ),
            _buildDashboardCard(
              context,
              title: 'Messages',
              icon: Icons.message,
              color: Colors.purple,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>  MessagesScreen()),
                );
              },
            ),
            _buildDashboardCard(
              context,
              title: 'Payments',
              icon: Icons.payment,
              color: Colors.teal,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>  PaymentsScreen()),
                );
              },
            ),
            _buildDashboardCard(
              context,
              title: 'Ratings & Reviews',
              icon: Icons.star,
              color: Colors.amber,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>  RatingsReviewsScreen()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
*//*
*//*
  Widget _buildDashboardCard(
      BuildContext context, {
        required String title,
        required IconData icon,
        required Color color,
        required VoidCallback onTap,
      }) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Container(
          decoration: BoxDecoration(
            color: color.withOpacity(0.1),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 48, color: color),
              const SizedBox(height: 10),
              Text(
                title,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: color,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
*//*

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
import 'package:buildbuddyfyp/Views/DashBoard/Contractor/ManageProjects.dart';
import 'package:buildbuddyfyp/Views/DashBoard/Contractor/MaterialOrders.dart';
import 'package:buildbuddyfyp/Views/DashBoard/Contractor/Messages.dart';
import 'package:buildbuddyfyp/Views/DashBoard/Contractor/Payments.dart';
import 'package:buildbuddyfyp/Views/DashBoard/Contractor/RatingAndReviews.dart';


class ContractorDashboard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Contractor Dashboard',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.blueAccent,
        elevation: 0,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.blueAccent, Colors.lightBlueAccent],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Welcome, Contractor!",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  "Here’s an overview of your activities:",
                  style: TextStyle(fontSize: 16, color: Colors.white70),
                ),
                SizedBox(height: 24),

                // Dashboard Cards
                _buildDashboardCard(
                  title: "Manage Projects",
                  icon: Icons.construction,
                  color: Colors.orange,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => ManageProjectsScreen()),
                    );
                  },
                ),
                SizedBox(height: 16),

                _buildDashboardCard(
                  title: "Material Orders",
                  icon: Icons.inventory,
                  color: Colors.green,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => MaterialOrdersScreen()),
                    );
                  },
                ),
                SizedBox(height: 16),

                _buildDashboardCard(
                  title: "Messages",
                  icon: Icons.message,
                  color: Colors.purple,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => MessagesScreen()),
                    );
                  },
                ),
                SizedBox(height: 16),

                _buildDashboardCard(
                  title: "Payments",
                  icon: Icons.payment,
                  color: Colors.teal,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => PaymentsScreen()),
                    );
                  },
                ),
                SizedBox(height: 16),

                _buildDashboardCard(
                  title: "Ratings & Reviews",
                  icon: Icons.star,
                  color: Colors.amber,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => RatingsReviewsScreen()),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDashboardCard({
    required String title,
    required IconData icon,
    required Color color,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        elevation: 6,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        child: Container(
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            gradient: LinearGradient(
              colors: [color.withOpacity(0.8), color],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: Row(
            children: [
              CircleAvatar(
                radius: 30,
                backgroundColor: Colors.white,
                child: Icon(icon, size: 30, color: color),
              ),
              SizedBox(width: 16),
              Expanded(
                child: Text(
                  title,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
              Icon(Icons.arrow_forward_ios, color: Colors.white),
            ],
          ),
        ),
      ),
    );
  }
}
*/
































/*
import 'package:flutter/material.dart';

class ContractorDashboard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Contractor Dashboard',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.blueAccent,
        elevation: 0,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.blueAccent, Colors.lightBlueAccent],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Welcome, Contractor!",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  "Here’s an overview of your activities:",
                  style: TextStyle(fontSize: 16, color: Colors.white70),
                ),
                SizedBox(height: 24),

                // Dashboard Cards
                _buildDashboardCard(
                  title: "Manage Projects",
                  icon: Icons.construction,
                  color: Colors.orange,
                  onTap: () {
                    // Navigate to project management screen
                  },
                ),
                SizedBox(height: 16),

                _buildDashboardCard(
                  title: "Material Orders",
                  icon: Icons.inventory,
                  color: Colors.green,
                  onTap: () {
                    // Navigate to material orders screen
                  },
                ),
                SizedBox(height: 16),

                _buildDashboardCard(
                  title: "Messages",
                  icon: Icons.message,
                  color: Colors.purple,
                  onTap: () {
                    // Navigate to chat system screen
                  },
                ),
                SizedBox(height: 16),

                _buildDashboardCard(
                  title: "Payments",
                  icon: Icons.payment,
                  color: Colors.teal,
                  onTap: () {
                    // Navigate to payment tracking screen
                  },
                ),
                SizedBox(height: 16),

                _buildDashboardCard(
                  title: "Ratings & Reviews",
                  icon: Icons.star,
                  color: Colors.amber,
                  onTap: () {
                    // Navigate to ratings and reviews screen
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDashboardCard({
    required String title,
    required IconData icon,
    required Color color,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        elevation: 6,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        child: Container(
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            gradient: LinearGradient(
              colors: [color.withOpacity(0.8), color],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: Row(
            children: [
              CircleAvatar(
                radius: 30,
                backgroundColor: Colors.white,
                child: Icon(icon, size: 30, color: color),
              ),
              SizedBox(width: 16),
              Expanded(
                child: Text(
                  title,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
              Icon(Icons.arrow_forward_ios, color: Colors.white),
            ],
          ),
        ),
      ),
    );
  }
}
*/
