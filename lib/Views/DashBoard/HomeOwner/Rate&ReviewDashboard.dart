import 'package:flutter/material.dart';

class RateReviewDashboard extends StatelessWidget {
  const RateReviewDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Rate & Review'),
        backgroundColor: const Color(0xFFFF8A65),
      ),
      body: ListView.builder(
        itemCount: 5,
        itemBuilder: (context, index) {
          return Card(
            margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ListTile(
                    leading: const Icon(Icons.person, color: Color(0xFFFF8A65)),
                    title: Text('Professional #${index + 1}'),
                    contentPadding: EdgeInsets.zero,
                  ),
                  const SizedBox(height: 8),
                  Wrap(
                    spacing: 4,
                    alignment: WrapAlignment.spaceBetween,
                    children: [
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: List.generate(5, (starIndex) {
                          return IconButton(
                            constraints: const BoxConstraints(
                              minWidth: 40,
                              maxWidth: 40,
                            ),
                            padding: EdgeInsets.zero,
                            icon: const Icon(Icons.star_border, color: Colors.amber),
                            onPressed: () {
                              // Handle rating logic
                            },
                          );
                        }),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          // Handle review submission
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFFFF8A65),
                          foregroundColor: Colors.white,
                        ),
                        child: const Text('Submit Review'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}