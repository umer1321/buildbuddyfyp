import 'package:flutter/material.dart';

class ManageProductsScreen extends StatelessWidget {
  // Sample product data with construction items and images
  final List<Map<String, String>> products = [
    {'name': 'Cement Bag (50kg)', 'price': '\$25', 'image': 'https://via.placeholder.com/150'},
    {'name': 'White Paint (1L)', 'price': '\$15', 'image': 'https://via.placeholder.com/150'},
    {'name': 'Steel Rod (12mm)', 'price': '\$50', 'image': 'https://via.placeholder.com/150'},
    {'name': 'Ceramic Tiles (1 Box)', 'price': '\$40', 'image': 'https://via.placeholder.com/150'},
    {'name': 'Wooden Plank (8ft)', 'price': '\$30', 'image': 'https://via.placeholder.com/150'},
    {'name': 'Brick Pack (100 pieces)', 'price': '\$60', 'image': 'https://via.placeholder.com/150'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Manage Products'),
        backgroundColor: Colors.teal,
        centerTitle: true,
        elevation: 4,
      ),
      body: Stack(
        children: [
          // Background shapes at the bottom
          Positioned(
            bottom: -150,
            left: -100,
            child: Container(
              width: 400,
              height: 350,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.blue,
              ),
            ),
          ),
          Positioned(
            bottom: -270,
            right: -150,
            child: Container(
              width: 500,
              height: 450,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Color(0xFF1a237e),
              ),
            ),
          ),

          // Product List
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ListView.builder(
              itemCount: products.length,
              itemBuilder: (context, index) {
                return Card(
                  elevation: 8,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  margin: EdgeInsets.symmetric(vertical: 8),
                  shadowColor: Colors.black.withOpacity(0.2),
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [Colors.blue.shade200, Colors.blue.shade100],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: ListTile(
                      contentPadding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                      leading: CircleAvatar(
                        backgroundImage: NetworkImage(products[index]['image']!),
                        radius: 30,
                      ),
                      title: Text(
                        products[index]['name'] ?? '',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.teal.shade800,
                        ),
                      ),
                      subtitle: Text(
                        'Price: ${products[index]['price']}',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.teal.shade600,
                        ),
                      ),
                      trailing: IconButton(
                        icon: Icon(Icons.edit, color: Colors.teal),
                        onPressed: () {
                          // Add your edit product logic here
                          print('Editing ${products[index]['name']}');
                        },
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
}
