import 'package:flutter/material.dart';

class VendorSupportScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Vendor Support'),
        backgroundColor: Colors.deepOrange,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'How can we help you?',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            ListTile(
              title: const Text('View FAQ'),
              subtitle: const Text('Browse through frequently asked questions.'),
              leading: const Icon(Icons.question_answer),
              onTap: () {
                // Navigate to FAQ page
              },
            ),
            const Divider(),
            ListTile(
              title: const Text('Contact Support'),
              subtitle: const Text('Get in touch with our support team.'),
              leading: const Icon(Icons.support_agent),
              onTap: () {
                // Navigate to contact form or support chat
              },
            ),
          ],
        ),
      ),
    );
  }
}
