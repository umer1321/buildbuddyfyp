import 'package:flutter/material.dart';

class VendorOrdersScreen extends StatelessWidget {
  // Sample data for orders
  final List<Map<String, String>> orders = [
    {'orderId': '001', 'customer': 'John Doe', 'status': 'Pending'},
    {'orderId': '002', 'customer': 'Jane Smith', 'status': 'Completed'},
    {'orderId': '003', 'customer': 'Michael Johnson', 'status': 'Shipped'},
    {'orderId': '004', 'customer': 'Emily Davis', 'status': 'Cancelled'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Orders'),
        backgroundColor: Colors.orange,
      ),
      body: Stack(
        children: [
          // Background shapes at the bottom
          Positioned(
            bottom: -100,
            left: -80,
            child: Container(
              width: 360,
              height: 250,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.orange.withOpacity(0.2),
              ),
            ),
          ),
          Positioned(
            bottom: -150,
            right: -120,
            child: Container(
              width: 400,
              height: 300,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.orange.withOpacity(0.1),
              ),
            ),
          ),

          // Orders List
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListView.builder(
              itemCount: orders.length,
              itemBuilder: (context, index) {
                final order = orders[index];
                return Card(
                  elevation: 4,
                  margin: const EdgeInsets.symmetric(vertical: 8),
                  child: ListTile(
                    leading: Icon(Icons.shopping_cart, color: Colors.blue),
                    title: Text('Order ID: ${order['orderId']}'),
                    subtitle: Text('Customer: ${order['customer']}'),
                    trailing: Text(
                      order['status']!,
                      style: TextStyle(
                        color: _getStatusColor(order['status']!),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case 'Pending':
        return Colors.orange;
      case 'Completed':
        return Colors.green;
      case 'Shipped':
        return Colors.blue;
      case 'Cancelled':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }
}



















/*
import 'package:flutter/material.dart';

class VendorOrdersScreen extends StatelessWidget {
  // Sample data for orders
  final List<Map<String, String>> orders = [
    {'orderId': '001', 'customer': 'John Doe', 'status': 'Pending'},
    {'orderId': '002', 'customer': 'Jane Smith', 'status': 'Completed'},
    {'orderId': '003', 'customer': 'Michael Johnson', 'status': 'Shipped'},
    {'orderId': '004', 'customer': 'Emily Davis', 'status': 'Cancelled'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Orders'),
        backgroundColor: Colors.orange,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView.builder(
          itemCount: orders.length,
          itemBuilder: (context, index) {
            final order = orders[index];
            return Card(
              elevation: 4,
              margin: const EdgeInsets.symmetric(vertical: 8),
              child: ListTile(
                leading: Icon(Icons.shopping_cart, color: Colors.blue),
                title: Text('Order ID: ${order['orderId']}'),
                subtitle: Text('Customer: ${order['customer']}'),
                trailing: Text(
                  order['status']!,
                  style: TextStyle(
                    color: _getStatusColor(order['status']!),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case 'Pending':
        return Colors.orange;
      case 'Completed':
        return Colors.green;
      case 'Shipped':
        return Colors.blue;
      case 'Cancelled':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }
}
*/
