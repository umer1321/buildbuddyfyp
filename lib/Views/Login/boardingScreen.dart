import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class BoardingScreen extends StatefulWidget {
  const BoardingScreen({super.key});

  @override
  BoardingScreenState createState() => BoardingScreenState();
}

class BoardingScreenState extends State<BoardingScreen> {
  final pageController = PageController();

  final List<Map<String, dynamic>> boardingData = [
    {
      'image': 'assets/1.png',
      'title': 'Welcome to BuildBuddy!',
      'description': 'Your ultimate app for productivity and innovation.',
    },
    {
      'image': 'assets/2.png',
      'title': 'Stay Organized',
      'description': 'Manage your tasks and projects seamlessly.',
    },
    {
      'image': 'assets/3.png',
      'title': 'Collaborate Effectively',
      'description': 'Work together with your team in real time.',
    },
    {
      'image': 'assets/4.png',
      'title': 'Streamlined Workflow',
      'description': 'Optimize processes and save valuable time.',
    },
    {
      'image': 'assets/5.png',
      'title': 'Powerful Analytics',
      'description': 'Gain insights and make informed decisions.',
    },
    {
      'image': 'assets/6.png',
      'title': 'Customizable Tools',
      'description': 'Tailor the app to suit your unique needs.',
    },
    {
      'image': 'assets/7.png',
      'title': 'Secure Platform',
      'description': 'Your data is safe with advanced encryption.',
    },
    {
      'image': 'assets/8.png',
      'title': 'User-Friendly Design',
      'description': 'Navigate with ease and enjoy the experience.',
    },
    {
      'image': 'assets/9.png',
      'title': 'Continuous Updates',
      'description': 'Experience new features regularly.',
    },
    {
      'image': 'assets/10.png',
      'title': 'Get Started Today',
      'description': 'Let’s build something amazing together!',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          PageView.builder(
            controller: pageController,
            itemCount: boardingData.length,
            itemBuilder: (context, index) => BoardingSlide(
              image: boardingData[index]['image'],
              title: boardingData[index]['title'],
              description: boardingData[index]['description'],
            ),
          ),
          Positioned(
            bottom: 32,
            left: 0,
            right: 0,
            child: Center(
              child: SmoothPageIndicator(
                controller: pageController,
                count: boardingData.length,
                effect: ExpandingDotsEffect(
                  activeDotColor: const Color(0xFFFFA726), // Construction orange
                  dotColor: Colors.grey.shade400, // Neutral gray
                  dotHeight: 10,
                  dotWidth: 10,
                  spacing: 8,
                ),
              ),
            ),
          ),
          Positioned(
            top: 48,
            right: 16,
            child: TextButton(
              onPressed: () {
                Navigator.pushNamed(context, '/stakeholder');
              },
              child: const Text(
                'Skip',
                style: TextStyle(
                  color: Colors.black87, // Dark gray for contrast
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class BoardingSlide extends StatelessWidget {
  final String image;
  final String title;
  final String description;

  const BoardingSlide({
    super.key,
    required this.image,
    required this.title,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.blue.shade200, Colors.blue.shade50],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Image with added shadow and rounded corners
          Container(
            margin: const EdgeInsets.symmetric(vertical: 20),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Image.asset(image, height: 300, width: 300, fit: BoxFit.cover),
            ),
          ),
          const SizedBox(height: 16),
          // Title with bold font and vibrant color
          Text(
            title,
            style: const TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: Color(0xFF212121), // Dark gray for titles
            ),
          ),
          const SizedBox(height: 12),
          // Description with softer color and medium font size
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32),
            child: Text(
              description,
              style: TextStyle(
                fontSize: 18,
                color: Colors.grey.shade700, // Soft gray for description
              ),
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(height: 30),
          // Call to action button with rounded corners
          if (image == 'assets/10.png')
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/stakeholder');
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFFFA726), // Construction orange
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 15),
                ),
                child: const Text(
                  'Get Started',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}



















