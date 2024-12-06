import 'package:flutter/material.dart';

class ViewProjectPlansScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Project Plans'),
        backgroundColor: Colors.blueGrey,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Text(
              'Project plans will be displayed here.',
              style: TextStyle(fontSize: 18),
            ),
            // Add more widgets to display actual project plans, such as a ListView or PDF viewer
          ],
        ),
      ),
    );
  }
}
