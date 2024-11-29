import 'package:flutter/material.dart';

class MaterialConsultationsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Material Consultations'),
        backgroundColor: Colors.green,
      ),
      body: ListView.builder(
        itemCount: 5, // Placeholder for material requests
        itemBuilder: (context, index) {
          return Card(
            margin: EdgeInsets.all(10),
            child: ListTile(
              leading: Icon(Icons.design_services, color: Colors.green),
              title: Text('Material Request ${index + 1}'),
              subtitle: Text('From: Vendor ${index + 1}'),
              trailing: IconButton(
                icon: Icon(Icons.edit, color: Colors.green),
                onPressed: () {
                  // Placeholder for approve/recommend
                },
              ),
            ),
          );
        },
      ),
    );
  }
}
