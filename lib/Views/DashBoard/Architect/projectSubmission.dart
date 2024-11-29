import 'package:flutter/material.dart';

class ProjectSubmissionsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Project Submissions'),
        backgroundColor: Colors.blue,
      ),
      body: ListView.builder(
        itemCount: 5, // Placeholder for dynamic data
        itemBuilder: (context, index) {
          return Card(
            margin: EdgeInsets.all(10),
            child: ListTile(
              leading: Icon(Icons.assignment, color: Colors.blue),
              title: Text('Submission ${index + 1}'),
              subtitle: Text('Status: Pending Review'),
              trailing: IconButton(
                icon: Icon(Icons.visibility, color: Colors.blue),
                onPressed: () {
                  // Placeholder for view submission
                },
              ),
            ),
          );
        },
      ),
    );
  }
}
