import 'package:flutter/material.dart';

import 'package:buildbuddyfyp/Views/DashBoard/HomeOwner/payment_detail.dart';

class PaymentsDashboard extends StatelessWidget {
  const PaymentsDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Payments & Invoices'),
        backgroundColor: const Color(0xFF9575CD),
      ),
      body: ListView.builder(
        itemCount: 10, // Placeholder for the number of payments/invoices
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Card(
              elevation: 10,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              color: Colors.white,
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.2),
                      spreadRadius: 3,
                      blurRadius: 6,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            const Icon(
                              Icons.receipt,
                              color: Color(0xFF9575CD),
                              size: 30,
                            ),
                            const SizedBox(width: 10),
                            Text(
                              'Invoice #${index + 1}',
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.black87,
                              ),
                            ),
                          ],
                        ),
                        Text(
                          '\$${(index + 1) * 100}',
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.green,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Due Date: ${(index + 1) * 5}th December 2024',
                      style: const TextStyle(
                        fontSize: 14,
                        color: Colors.black54,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            // Handle payment logic
                          },
                          style: ElevatedButton.styleFrom(
                            foregroundColor: Colors.white, backgroundColor: const Color(0xFF9575CD),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 14, vertical: 10),
                          ),
                          child: const Text('Pay Now'),
                        ),
                        TextButton(
                          onPressed: () {
                            // Navigate to the invoice details screen
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => InvoiceDetailsScreen(
                                  invoiceNumber: index + 1,
                                  amount: (index + 1) * 100.0,
                                  dueDate: '${(index + 1) * 5}th December 2024',
                                  description: 'Detailed information about the invoice goes here. You can include timestamps, description, and other relevant data.',
                                ),
                              ),
                            );
                          },
                          child: const Text(
                            'View Details',
                            style: TextStyle(color: Color(0xFF9575CD)),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    LinearProgressIndicator(
                      value: 0.5, // Example for 50% paid
                      backgroundColor: Colors.grey[300],
                      color: Colors.green,
                    ),
                    const SizedBox(height: 5),
                    const Text(
                      '50% Paid',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.green,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
