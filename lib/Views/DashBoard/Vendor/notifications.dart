import 'package:flutter/material.dart';

class VendorNotificationsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Vendor Notifications'),
        backgroundColor: Colors.deepPurpleAccent,
        centerTitle: true,
        elevation: 6,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView.builder(
          itemCount: 10, // Example number of notifications
          itemBuilder: (context, index) {
            return Card(
              elevation: 6,
              margin: const EdgeInsets.symmetric(vertical: 12),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Colors.deepPurple.shade100, Colors.deepPurple.shade50],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: ListTile(
                  contentPadding: EdgeInsets.zero,
                  leading: CircleAvatar(
                    backgroundColor: Colors.deepPurpleAccent.shade100,
                    radius: 28,
                    child: Icon(Icons.notifications, color: Colors.deepPurpleAccent.shade700, size: 28),
                  ),
                  title: Text(
                    'New Order Alert #${index + 1}',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                      color: Colors.deepPurpleAccent.shade700,
                    ),
                  ),
                  subtitle: Text(
                    'You have a new order to process.',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.deepPurpleAccent.shade400,
                    ),
                  ),
                  trailing: IconButton(
                    icon: const Icon(Icons.check_circle, color: Colors.green, size: 28),
                    onPressed: () {
                      // Handle notification read logic here
                    },
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
