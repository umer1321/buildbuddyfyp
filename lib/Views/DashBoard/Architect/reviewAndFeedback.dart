import 'package:flutter/material.dart';

class ReviewsFeedbackScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Reviews & Feedback'),
        backgroundColor: Colors.redAccent,
      ),
      body: ListView.builder(
        itemCount: 5, // Placeholder for dynamic reviews
        itemBuilder: (context, index) {
          return Card(
            margin: EdgeInsets.all(10),
            child: ListTile(
              leading: Icon(Icons.feedback, color: Colors.redAccent),
              title: Text('Review ${index + 1}'),
              subtitle: Text('Rating: ${index + 3}/5'),
              trailing: IconButton(
                icon: Icon(Icons.arrow_forward, color: Colors.redAccent),
                onPressed: () {
                  // Placeholder for detailed review
                },
              ),
            ),
          );
        },
      ),
    );
  }
}
