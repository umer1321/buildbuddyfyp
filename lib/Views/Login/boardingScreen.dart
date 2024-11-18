import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:buildbuddyfyp/Views/Login/startedScreen.dart';

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
                  activeDotColor: Colors.blue,
                  dotColor: Colors.grey.shade400,
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
                // Navigate to the get started screen
                //Navigator.pushNamed(context, '/get-started');

                  Navigator.pushNamed(context, '/stakeholder');


              },
              child: const Text('Skip'),
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
      //color: const Color(0xFFF5F5F5), // Custom light grey background color
      color: Colors.lightBlue.shade50,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(image, height: 300),
          const SizedBox(height: 32),
          Text(
            title,
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32),
            child: Text(
              description,
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey.shade600,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}
