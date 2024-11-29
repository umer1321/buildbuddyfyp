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
