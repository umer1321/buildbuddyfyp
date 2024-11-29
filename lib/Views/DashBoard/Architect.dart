import 'package:flutter/material.dart';

class ArchitectDashboard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Architect Dashboard'),
        backgroundColor: Colors.blueGrey,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: GridView.count(
          crossAxisCount: 2,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
          children: [
            _buildDashboardCard(
              context,
              title: 'Project Submissions',
              icon: Icons.assignment,
              color: Colors.blue,
              onTap: () {
                Navigator.pushNamed(context, '/project-submissions');
              },
            ),
            _buildDashboardCard(
              context,
              title: 'Task Assignments',
              icon: Icons.task,
              color: Colors.orange,
              onTap: () {
                Navigator.pushNamed(context, '/task-assignments');
              },
            ),
            _buildDashboardCard(
              context,
              title: 'Material Consultations',
              icon: Icons.design_services,
              color: Colors.green,
              onTap: () {
                Navigator.pushNamed(context, '/material-consultations');
              },
            ),
            _buildDashboardCard(
              context,
              title: 'Messages',
              icon: Icons.message,
              color: Colors.purple,
              onTap: () {
                Navigator.pushNamed(context, '/architect-messages');
              },
            ),
            _buildDashboardCard(
              context,
              title: 'Reviews & Feedback',
              icon: Icons.feedback,
              color: Colors.redAccent,
              onTap: () {
                Navigator.pushNamed(context, '/reviews-feedback');
              },
            ),
          ],
        ),
      ),
    );
  }

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
              SizedBox(height: 10),
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
