import 'package:flutter/material.dart';

class ReviewContractorTasksScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Contractor Tasks Review'),
        backgroundColor: Colors.green[800],
        elevation: 0,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView.builder(
          itemCount: 10, // Example number of tasks
          itemBuilder: (context, index) {
            return Card(
              elevation: 4,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              margin: const EdgeInsets.symmetric(vertical: 8),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Task Icon
                    const Icon(
                      Icons.design_services,
                      size: 50,
                      color: Colors.green,
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Task Name
                          Text(
                            'Task #${index + 1}: Review Project Details',
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 8),

                          // Task Description
                          const Text(
                            'Check if contractor has followed the design specifications. Ensure that measurements, materials, and structural components are accurate.',
                            style: TextStyle(fontSize: 14),
                          ),
                          const SizedBox(height: 8),

                          // Task Status
                          Text(
                            'Status: ${index % 2 == 0 ? "Pending" : "Completed"}',
                            style: TextStyle(
                              fontSize: 14,
                              color: index % 2 == 0 ? Colors.orange : Colors.green,
                            ),
                          ),
                        ],
                      ),
                    ),

                    // Approve/Review Button
                    IconButton(
                      icon: Icon(
                        index % 2 == 0 ? Icons.check_circle_outline : Icons.check_circle,
                        color: index % 2 == 0 ? Colors.orange : Colors.green,
                        size: 30,
                      ),
                      onPressed: () {
                        // Handle task approval/review logic here
                        showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                            title: const Text('Review Task'),
                            content: const Text(
                                'Are you sure the contractor has completed the task according to the design?'),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: const Text('Cancel'),
                              ),
                              TextButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                  // Handle task completion logic here
                                },
                                child: const Text('Approve'),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
