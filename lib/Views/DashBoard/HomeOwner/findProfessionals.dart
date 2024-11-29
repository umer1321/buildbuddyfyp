import 'package:flutter/material.dart';

class FindProfessionalsDashboard extends StatelessWidget {
  const FindProfessionalsDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Find Professionals'),
        backgroundColor: const Color(0xFF2196F3),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            ProfessionalCard(name: 'John Doe', role: 'Architect', rating: 4.5),
            ProfessionalCard(name: 'Jane Smith', role: 'Contractor', rating: 4.8),
            ProfessionalCard(name: 'Mike Johnson', role: 'Electrician', rating: 4.2),
          ],
        ),
      ),
    );
  }
}

class ProfessionalCard extends StatelessWidget {
  final String name;
  final String role;
  final double rating;

  const ProfessionalCard({required this.name, required this.role, required this.rating, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      margin: const EdgeInsets.only(bottom: 16),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: Colors.blueAccent,
          child: Text(name[0], style: const TextStyle(color: Colors.white)),
        ),
        title: Text(name, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(role),
        trailing: Text('$rating⭐', style: const TextStyle(color: Colors.orange)),
      ),
    );
  }
}
