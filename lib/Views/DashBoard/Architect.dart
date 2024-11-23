import 'package:flutter/material.dart';

class ArchitectDashboard extends StatelessWidget {
  const ArchitectDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Architect Dashboard')),
      body: const Center(
        child: Text('Welcome to the Architect Dashboard!'),
      ),
    );
  }
}