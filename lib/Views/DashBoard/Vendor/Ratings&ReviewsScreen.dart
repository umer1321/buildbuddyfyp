import 'package:flutter/material.dart';

class VendorReviewsScreen extends StatelessWidget {
  // Sample data for reviews
  final List<Map<String, dynamic>> reviews = [
    {
      'reviewer': 'John Doe',
      'rating': 4.5,
      'comment': 'Great product quality and timely delivery.',
      'date': '2024-11-01'
    },
    {
      'reviewer': 'Jane Smith',
      'rating': 3.0,
      'comment': 'Product was good but shipping took too long.',
      'date': '2024-11-10'
    },
    {
      'reviewer': 'Michael Johnson',
      'rating': 5.0,
      'comment': 'Excellent service! Will definitely purchase again.',
      'date': '2024-10-25'
    },
    {
      'reviewer': 'Emily Davis',
      'rating': 4.0,
      'comment': 'Satisfactory experience, though a bit expensive.',
      'date': '2024-11-15'
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Ratings & Reviews'),
        backgroundColor: Colors.redAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView.builder(
          itemCount: reviews.length,
          itemBuilder: (context, index) {
            final review = reviews[index];
            return Card(
              elevation: 4,
              margin: const EdgeInsets.symmetric(vertical: 8),
              child: ListTile(
                leading: Icon(
                  Icons.star_rate,
                  color: Colors.orange,
                ),
                title: Text(review['reviewer']!),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: List.generate(5, (index) {
                        return Icon(
                          Icons.star,
                          size: 16,
                          color: index < review['rating']! ? Colors.orange : Colors.grey,
                        );
                      }),
                    ),
                    SizedBox(height: 5),
                    Text(
                      review['comment']!,
                      style: TextStyle(color: Colors.grey),
                    ),
                    SizedBox(height: 5),
                    Text(
                      'Date: ${review['date']}',
                      style: TextStyle(color: Colors.grey),
                    ),
                  ],
                ),
                onTap: () {
                  // Placeholder for detailed review view
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Viewing review by ${review['reviewer']}')),
                  );
                },
              ),
            );
          },
        ),
      ),
    );
  }
}
