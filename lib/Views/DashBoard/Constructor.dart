import 'package:flutter/material.dart';

class ContractorDashboard extends StatelessWidget {
  const ContractorDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Contractor Dashboard')),
      body: const Center(
        child: Text('Welcome to the Contractor Dashboard!'),
      ),
    );
  }
}