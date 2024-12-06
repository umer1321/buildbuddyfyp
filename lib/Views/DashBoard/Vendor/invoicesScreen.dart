import 'package:flutter/material.dart';

class VendorInvoicesScreen extends StatelessWidget {
  // Sample data for invoices
  final List<Map<String, dynamic>> invoices = [
    {'invoiceId': 'INV001', 'amount': 150.00, 'status': 'Paid', 'date': '2024-11-01'},
    {'invoiceId': 'INV002', 'amount': 200.00, 'status': 'Pending', 'date': '2024-11-10'},
    {'invoiceId': 'INV003', 'amount': 350.00, 'status': 'Overdue', 'date': '2024-10-25'},
    {'invoiceId': 'INV004', 'amount': 100.00, 'status': 'Paid', 'date': '2024-11-15'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Invoices'),
        backgroundColor: Colors.green,
      ),
      body: Stack(
        children: [
          // Background shapes at the bottom
          Positioned(
            bottom: -120,
            left: -100,
            child: Container(
              width: 360,
              height: 300,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.green.withOpacity(0.2),
              ),
            ),
          ),
          Positioned(
            bottom: -180,
            right: -140,
            child: Container(
              width: 400,
              height: 350,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.blue.withOpacity(0.5),
              ),
            ),
          ),

          // Invoices List
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListView.builder(
              itemCount: invoices.length,
              itemBuilder: (context, index) {
                final invoice = invoices[index];
                return Card(
                  elevation: 4,
                  margin: const EdgeInsets.symmetric(vertical: 8),
                  child: ListTile(
                    leading: Icon(Icons.receipt, color: Colors.blue),
                    title: Text('Invoice ID: ${invoice['invoiceId']}'),
                    subtitle: Text('Date: ${invoice['date']}'),
                    trailing: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          '\$${invoice['amount'].toStringAsFixed(2)}',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text(
                          invoice['status'],
                          style: TextStyle(
                            color: _getStatusColor(invoice['status']),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
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
      case 'Paid':
        return Colors.green;
      case 'Pending':
        return Colors.orange;
      case 'Overdue':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }
}
