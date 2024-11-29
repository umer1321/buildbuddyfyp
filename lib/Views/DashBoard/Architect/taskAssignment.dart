import 'package:flutter/material.dart';

class TaskAssignmentsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Task Assignments'),
        backgroundColor: Colors.orange,
      ),
      body: ListView.builder(
        itemCount: 5, // Placeholder for dynamic tasks
        itemBuilder: (context, index) {
          return Card(
            margin: EdgeInsets.all(10),
            child: ListTile(
              leading: Icon(Icons.task, color: Colors.orange),
              title: Text('Task ${index + 1}'),
              subtitle: Text('Assigned to: Contractor ${index + 1}'),
              trailing: IconButton(
                icon: Icon(Icons.check, color: Colors.orange),
                onPressed: () {
                  // Placeholder for mark as completed
                },
              ),
            ),
          );
        },
      ),
    );
  }
}
