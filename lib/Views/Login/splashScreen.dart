import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  SplashScreenState createState() => SplashScreenState();
}

class SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  late Animation<double> _scaleAnimation;
  late Animation<double> _moveUpAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(seconds: 6),
      vsync: this,
    );

    // Fade animation for opacity effect
    _fadeAnimation = Tween<double>(begin: 1.0, end: 0.0).animate(_animationController);

    // Scale animation for logo zoom effect
    _scaleAnimation = Tween<double>(begin: 0.8, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeInOut,
      ),
    );

    // Move-up animation for tagline
    _moveUpAnimation = Tween<double>(begin: 30.0, end: 0.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeOut,
      ),
    );

    _animationController.addListener(() {
      if (_animationController.status == AnimationStatus.completed) {
        Navigator.pushReplacementNamed(context, '/boarding');
      }
    });

    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // New Dynamic Background with a rich gradient and subtle texture
          Container(
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Color(0xFF1D3557), Color(0xFF457B9D)], // Deep blue to teal
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: Center(
              child: Container(
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Colors.transparent, Colors.black45],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                ),
              ),
            ),
          ),
          // Centered logo and project name with animations
          Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Logo with scaling and fading effect
                FadeTransition(
                  opacity: _fadeAnimation,
                  child: ScaleTransition(
                    scale: _scaleAnimation,
                    child: Image.asset('assets/logo.png', width: 180),
                  ),
                ),
                const SizedBox(height: 20),
                // Project name with bold text style
                FadeTransition(
                  opacity: _fadeAnimation,
                  child: const Text(
                    'Build Buddy',
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      letterSpacing: 2.0,
                      shadows: [
                        Shadow(
                          color: Colors.black45,
                          offset: Offset(2, 2),
                          blurRadius: 8.0,
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                // Tagline with subtle style and color contrast
                AnimatedBuilder(
                  animation: _moveUpAnimation,
                  builder: (context, child) {
                    return Transform.translate(
                      offset: Offset(0, _moveUpAnimation.value),
                      child: FadeTransition(
                        opacity: _fadeAnimation,
                        child: const Text(
                          'Building Dreams, One Step at a Time',
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.white70,
                            fontStyle: FontStyle.italic,
                            letterSpacing: 1.5,
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}





/*
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  SplashScreenState createState() => SplashScreenState();
}

class SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    );

    _fadeAnimation = Tween<double>(begin: 1.0, end: 0.0).animate(_animationController);

    _animationController.addListener(() {
      if (_animationController.status == AnimationStatus.completed) {
        // Navigate to the next screen after the animation is complete
        Navigator.pushReplacementNamed(context, '/boarding');
      }
    });

    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background color or image
          Container(
            color: Colors.white,
          ),
          // Animated app logo
          Center(
            child: FadeTransition(
              opacity: _fadeAnimation,
              child: Image.asset('assets/logo.png', width: 120),
            ),
          ),
        ],
      ),
    );
  }
}*/
