import 'package:flutter/material.dart';

class PaymentsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Payments'),
        backgroundColor: Colors.teal,
      ),
      body: ListView.builder(
        itemCount: 5, // Replace with dynamic payment count
        itemBuilder: (context, index) {
          return Card(
            margin: EdgeInsets.all(10),
            child: ListTile(
              leading: Icon(Icons.payment, color: Colors.teal),
              title: Text('Payment ${index + 1}'),
              subtitle: Text('Amount: \$${(index + 1) * 100}'),
              trailing: Icon(Icons.check_circle, color: Colors.teal),
            ),
          );
        },
      ),
    );
  }
}
