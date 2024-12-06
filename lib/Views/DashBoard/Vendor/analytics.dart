import 'package:flutter/material.dart';

class VendorAnalyticsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Vendor Analytics'),
        backgroundColor: Colors.indigo,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Business Overview:',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            _buildStatCard('Total Orders', '150 Orders', Colors.blue),
            _buildStatCard('Total Revenue', '\$12,500', Colors.green),
            _buildStatCard('Pending Orders', '5 Orders', Colors.orange),
            _buildStatCard('Total Products', '45 Products', Colors.purple),
          ],
        ),
      ),
    );
  }

  Widget _buildStatCard(String title, String value, Color color) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        leading: Icon(Icons.show_chart, color: color),
        title: Text(title, style: TextStyle(fontSize: 16)),
        trailing: Text(value, style: TextStyle(fontSize: 16, color: color)),
      ),
    );
  }
}
