import 'package:flutter/material.dart';

class MaterialOrdersScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Material Orders'),
        backgroundColor: Colors.green,
      ),
      body: ListView.builder(
        itemCount: 5, // Replace with dynamic order count
        itemBuilder: (context, index) {
          return Card(
            margin: EdgeInsets.all(10),
            child: ListTile(
              leading: Icon(Icons.inventory, color: Colors.green),
              title: Text('Order ${index + 1}'),
              subtitle: Text('Status: Delivered'),
              trailing: IconButton(
                icon: Icon(Icons.info, color: Colors.green),
                onPressed: () {
                  // Placeholder for order details
                },
              ),
            ),
          );
        },
      ),
    );
  }
}
