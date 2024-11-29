import 'package:flutter/material.dart';

class MyProjectsDashboard extends StatelessWidget {
  const MyProjectsDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Projects'),
        backgroundColor: const Color(0xFF4CAF50),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            ProjectCard(title: 'Kitchen Renovation', status: 'In Progress'),
            ProjectCard(title: 'Living Room Remodeling', status: 'Completed'),
            ProjectCard(title: 'Garage Upgrade', status: 'Pending'),
          ],
        ),
      ),
    );
  }
}

class ProjectCard extends StatelessWidget {
  final String title;
  final String status;

  const ProjectCard({required this.title, required this.status, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      margin: const EdgeInsets.only(bottom: 16),
      child: ListTile(
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text('Status: $status'),
        trailing: Icon(
          status == 'Completed'
              ? Icons.check_circle
              : Icons.pending_actions,
          color: status == 'Completed' ? Colors.green : Colors.orange,
        ),
      ),
    );
  }
}
