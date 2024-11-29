import 'package:flutter/material.dart';

class ManageProjectsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Manage Projects'),
        backgroundColor: Colors.orange,
      ),
      body: ListView.builder(
        itemCount: 5, // Replace with dynamic project count
        itemBuilder: (context, index) {
          return Card(
            margin: EdgeInsets.all(10),
            child: ListTile(
              leading: Icon(Icons.work, color: Colors.orange),
              title: Text('Project ${index + 1}'),
              subtitle: Text('Status: Ongoing'),
              trailing: IconButton(
                icon: Icon(Icons.edit, color: Colors.orange),
                onPressed: () {
                  // Placeholder for edit functionality
                },
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Placeholder for add project functionality
        },
        backgroundColor: Colors.orange,
        child: Icon(Icons.add),
      ),
    );
  }
}
