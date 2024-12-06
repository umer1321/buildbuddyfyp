import 'package:flutter/material.dart';

class MessagesDashboard extends StatelessWidget {
  const MessagesDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Messages'),
        backgroundColor: const Color(0xFFFF9800),
      ),
      body: Stack(
        children: [
          // ListView displaying messages
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ListView(
              children: const [
                MessageTile(sender: 'John Doe', message: 'Can we discuss the project timeline?', time: '2:30 PM'),
                MessageTile(sender: 'Jane Smith', message: 'I have sent the invoice.', time: '1:15 PM'),
                MessageTile(sender: 'Mike Johnson', message: 'Your order has been shipped.', time: '11:00 AM'),
              ],
            ),
          ),
          // Positioned elements at the bottom
          Positioned(
            bottom: -60,
            left: -100,
            child: Container(
              width: 360,
              height: 250,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: const Color(0xFFFFF3E0), // Light yellow
              ),
            ),
          ),
          Positioned(
            bottom: -80,
            right: -80,
            child: Container(
              width: 360,
              height: 250,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: const Color(0xFFFF7043), // Light orange
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class MessageTile extends StatelessWidget {
  final String sender;
  final String message;
  final String time;

  const MessageTile({required this.sender, required this.message, required this.time, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      margin: const EdgeInsets.only(bottom: 16),
      child: ListTile(
        title: Text(sender, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(message),
        trailing: Text(time, style: const TextStyle(color: Colors.grey)),
      ),
    );
  }
}
