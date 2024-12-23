/*import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();

    // Increased duration for slower construction
    _animationController = AnimationController(
      duration: const Duration(seconds: 10),  // Increased from 6 to 10 seconds
      vsync: this,
    );

    // Curved animation with more pronounced easing
    _animation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeInOutQuad,  // Slightly modified curve
      ),
    );

    // Start animation and navigate after completion
    _animationController.forward().then((_) {
      Navigator.pushReplacementNamed(context, '/boarding');
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AnimatedBuilder(
              animation: _animation,
              builder: (context, child) {
                return CustomPaint(
                  painter: ColorfulHouseIconPainter(_animation.value),
                  child: SizedBox(
                    width: 300,
                    height: 400,
                  ),
                );
              },
            ),
            const SizedBox(height: 20), // Space between house and text
            AnimatedOpacity(
              opacity: _animation.value == 1.0 ? 1.0 : 0.0,
              duration: const Duration(milliseconds: 500),
              child: const Text(
                'BuildBuddy',
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: Colors.blueGrey,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ColorfulHouseIconPainter extends CustomPainter {
  final double progress;

  ColorfulHouseIconPainter(this.progress);

  @override
  void paint(Canvas canvas, Size size) {
    // Vibrant background
    _paintSkyBackground(canvas, size);

    // Ground (Lush Grass Icon)
    if (progress <= 0.2) {
      _paintGroundIcon(canvas, size, progress * 5);
    }

    // Foundation (Brick Foundation Icon)
    if (progress > 0.1 && progress <= 0.3) {
      _paintFoundationIcon(canvas, size, (progress - 0.1) * 5);
    }

    // Walls (Colorful Walls Icon)
    if (progress > 0.2 && progress <= 0.5) {
      _paintWallsIcon(canvas, size, (progress - 0.2) * 3.33);
    }

    // Windows (Bright Windows Icon)
    if (progress > 0.4 && progress <= 0.6) {
      _paintWindowsIcon(canvas, size, (progress - 0.4) * 5);
    }

    // Roof (Textured Roof Icon)
    if (progress > 0.5 && progress <= 0.8) {
      _paintRoofIcon(canvas, size, (progress - 0.5) * 3);
    }

    // Final Details (Complete Colorful House Icon)
    if (progress > 0.7) {
      _paintFinalHouseIcon(canvas, size, (progress - 0.7) * 3.33);
    }
  }

  void _paintSkyBackground(Canvas canvas, Size size) {
    final skyPaint = Paint()
      ..shader = LinearGradient(
        colors: [
          Colors.lightBlueAccent.shade100,
          Colors.lightBlueAccent.shade200,
        ],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      ).createShader(Rect.fromLTWH(0, 0, size.width, size.height));

    canvas.drawRect(
      Rect.fromLTWH(0, 0, size.width, size.height),
      skyPaint,
    );
  }

  void _paintGroundIcon(Canvas canvas, Size size, double stageProgress) {
    final groundPaint = Paint()
      ..shader = LinearGradient(
        colors: [
          Colors.green.shade300.withOpacity(0.5 * stageProgress),
          Colors.green.shade600.withOpacity(0.5 * stageProgress),
        ],
      ).createShader(Rect.fromLTWH(0, size.height * 0.8, size.width, size.height * 0.2));

    canvas.drawRect(
      Rect.fromLTWH(0, size.height * 0.8, size.width, size.height * 0.2 * stageProgress),
      groundPaint,
    );

    // Add some grass blades
    final grassPaint = Paint()
      ..color = Colors.green.shade700.withOpacity(0.7 * stageProgress)
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;

    for (int i = 0; i < 10; i++) {
      final x = size.width * (0.1 + i * 0.08);
      canvas.drawLine(
        Offset(x, size.height * 0.8),
        Offset(x, size.height * 0.8 - 20 * stageProgress),
        grassPaint,
      );
    }
  }

  void _paintFoundationIcon(Canvas canvas, Size size, double stageProgress) {
    final foundationPaint = Paint()
      ..color = Colors.brown.shade500.withOpacity(0.7 * stageProgress)
      ..style = PaintingStyle.fill;

    canvas.drawRect(
      Rect.fromLTWH(
        size.width * 0.2,
        size.height * 0.7,
        size.width * 0.6 * stageProgress,
        size.height * 0.1,
      ),
      foundationPaint,
    );
  }

  void _paintWallsIcon(Canvas canvas, Size size, double stageProgress) {
    final wallPaint = Paint()
      ..shader = LinearGradient(
        colors: [
          Colors.blueGrey.shade200.withOpacity(0.7 * stageProgress),
          Colors.blueGrey.shade400.withOpacity(0.7 * stageProgress),
        ],
      ).createShader(Rect.fromLTWH(
        size.width * 0.2,
        size.height * 0.4,
        size.width * 0.6,
        size.height * 0.4,
      ));

    canvas.drawRect(
      Rect.fromLTWH(
        size.width * 0.2,
        size.height * 0.4,
        size.width * 0.6 * stageProgress,
        size.height * 0.4,
      ),
      wallPaint,
    );
  }

  void _paintWindowsIcon(Canvas canvas, Size size, double stageProgress) {
    final windowPaint = Paint()
      ..color = Colors.lightBlue.shade200.withOpacity(0.8 * stageProgress)
      ..style = PaintingStyle.fill;

    final windowFramePaint = Paint()
      ..color = Colors.grey.shade700.withOpacity(0.8 * stageProgress)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;

    // Left window
    canvas.drawRect(
      Rect.fromCenter(
        center: Offset(size.width * 0.35, size.height * 0.5),
        width: 50 * stageProgress,
        height: 50 * stageProgress,
      ),
      windowPaint,
    );
    canvas.drawRect(
      Rect.fromCenter(
        center: Offset(size.width * 0.35, size.height * 0.5),
        width: 50 * stageProgress,
        height: 50 * stageProgress,
      ),
      windowFramePaint,
    );

    // Right window
    canvas.drawRect(
      Rect.fromCenter(
        center: Offset(size.width * 0.65, size.height * 0.5),
        width: 50 * stageProgress,
        height: 50 * stageProgress,
      ),
      windowPaint,
    );
    canvas.drawRect(
      Rect.fromCenter(
        center: Offset(size.width * 0.65, size.height * 0.5),
        width: 50 * stageProgress,
        height: 50 * stageProgress,
      ),
      windowFramePaint,
    );
  }

  void _paintRoofIcon(Canvas canvas, Size size, double stageProgress) {
    final roofPaint = Paint()
      ..shader = LinearGradient(
        colors: [
          Colors.red.shade300.withOpacity(0.7 * stageProgress),
          Colors.red.shade500.withOpacity(0.7 * stageProgress),
        ],
      ).createShader(Rect.fromLTWH(
        size.width * 0.2,
        size.height * 0.2,
        size.width * 0.6,
        size.height * 0.2,
      ));

    final roofPath = Path();
    roofPath.moveTo(size.width * 0.2, size.height * 0.4);
    roofPath.lineTo(size.width * 0.5, size.height * 0.2 - (size.height * 0.2 * (1 - stageProgress)));
    roofPath.lineTo(size.width * 0.8, size.height * 0.4);
    roofPath.close();

    canvas.drawPath(roofPath, roofPaint);

    // Roof tiles
    final tilePaint = Paint()
      ..color = Colors.red.shade700.withOpacity(0.5 * stageProgress)
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;

    for (int i = 1; i < 5; i++) {
      canvas.drawLine(
        Offset(size.width * 0.2, size.height * 0.4 - i * size.height * 0.04 * stageProgress),
        Offset(size.width * 0.8, size.height * 0.4 - i * size.height * 0.04 * stageProgress),
        tilePaint,
      );
    }
  }

  void _paintFinalHouseIcon(Canvas canvas, Size size, double stageProgress) {
    // Chimney
    final chimneyPaint = Paint()
      ..color = Colors.brown.shade600.withOpacity(0.7 * stageProgress)
      ..style = PaintingStyle.fill;

    canvas.drawRect(
      Rect.fromLTWH(
        size.width * 0.7,
        size.height * 0.2,
        20 * stageProgress,
        50 * stageProgress,
      ),
      chimneyPaint,
    );

    // Door
    final doorPaint = Paint()
      ..color = Colors.brown.shade400.withOpacity(0.7 * stageProgress)
      ..style = PaintingStyle.fill;

    canvas.drawRect(
      Rect.fromLTWH(
        size.width * 0.45,
        size.height * 0.6,
        40 * stageProgress,
        80 * stageProgress,
      ),
      doorPaint,
    );

    // Doorknob
    final doorknobPaint = Paint()
      ..color = Colors.grey.shade700.withOpacity(0.7 * stageProgress)
      ..style = PaintingStyle.fill;

    canvas.drawCircle(
      Offset(
        size.width * 0.75,
        size.height * 0.65,
      ),
      5 * stageProgress,
      doorknobPaint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}*/



















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
  late Animation<double> _scaleAnimation;
  late Animation<double> _moveUpAnimation;
  late Animation<double> _rotateAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(seconds: 9), // Matching video duration
      vsync: this,
    );

    // Fading effect
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Interval(0.0, 0.3, curve: Curves.easeIn),
      ),
    );

    // Scaling effect
    _scaleAnimation = Tween<double>(begin: 0.5, end: 1.2).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Interval(0.3, 0.6, curve: Curves.easeInOut),
      ),
    );

    // Moving up effect
    _moveUpAnimation = Tween<double>(begin: 30.0, end: -50.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Interval(0.6, 0.9, curve: Curves.easeOut),
      ),
    );

    // Rotating effect
    _rotateAnimation = Tween<double>(begin: 0.0, end: 2.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Interval(0.6, 1.0, curve: Curves.easeInOut),
      ),
    );

    _animationController.forward();

    _animationController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        Navigator.pushReplacementNamed(context, '/boarding');
      }
    });
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
          // Background gradient
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFF1D3557), Color(0xFF457B9D)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
          ),
          // Logo with animations
          Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                FadeTransition(
                  opacity: _fadeAnimation,
                  child: ScaleTransition(
                    scale: _scaleAnimation,
                    child: RotationTransition(
                      turns: _rotateAnimation,
                      child: Image.asset('assets/logo.png', width: 200),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                // Tagline moving up and fading in
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
                            color: Colors.white,
                            fontStyle: FontStyle.italic,
                            letterSpacing: 1.5,
                          ),
                          textAlign: TextAlign.center,
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
*/

import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  SplashScreenState createState() => SplashScreenState();
}

class SplashScreenState extends State<SplashScreen> {
  late VideoPlayerController _controller;
  late double _videoDuration;
  late double _currentPosition;

  // Initial background color
  Color _startColor = const Color(0xFF6A82FB); // Soft Blue
  Color _endColor = const Color(0xFFFC5C7D); // Soft Pink

  @override
  void initState() {
    super.initState();

    // Initialize video controller with your video file
    _controller = VideoPlayerController.asset('assets/animation.mp4')
      ..initialize().then((_) {
        setState(() {
          _videoDuration = _controller.value.duration.inMilliseconds.toDouble();
        });
        _controller.play(); // Start playing the video
        _controller.setLooping(false); // Disable looping if you only want to show it once
      });

    // Update the background color as the video plays
    _controller.addListener(() {
      setState(() {
        _currentPosition = _controller.value.position.inMilliseconds.toDouble();
        // Change color as the video progresses
        double progress = _currentPosition / _videoDuration;
        _startColor = Color.lerp(const Color(0xFF6A82FB), const Color(0xFFFC5C7D), progress)!;
        _endColor = Color.lerp(const Color(0xFFFC5C7D), const Color(0xFF6A82FB), progress)!;
      });

      if (_controller.value.position == _controller.value.duration) {
        // Video has finished playing, navigate to the next screen
        Navigator.pushReplacementNamed(context, '/boarding'); // Use named route '/boarding'
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose(); // Dispose of the video controller to release resources
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimatedContainer(
        duration: const Duration(milliseconds: 500), // Smooth transition for background color
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [_startColor, _endColor], // Dynamic colors changing as video progresses
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Center(
          child: _controller.value.isInitialized
              ? AspectRatio(
            aspectRatio: _controller.value.aspectRatio,
            child: VideoPlayer(_controller),
          )
              : const CircularProgressIndicator(), // Show loading while video is initializing
        ),
      ),
    );
  }
}

















/*
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/animation.dart';

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
  late Animation<double> _rotateAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(seconds: 5),
      vsync: this,
    );

    // Fade animation for opacity effect
    _fadeAnimation = Tween<double>(begin: 1.0, end: 0.0).animate(_animationController);

    // Scale animation for logo zoom effect
    _scaleAnimation = Tween<double>(begin: 0.7, end: 1.0).animate(
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

    // Rotation animation for logo
    _rotateAnimation = Tween<double>(begin: 0.0, end: 0.25).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeInOut,
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
          // Dynamic Background with blur effect
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
                    colors: [Colors.transparent, Colors.black54],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                ),
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 4.0, sigmaY: 4.0),
                  child: Container(),
                ),
              ),
            ),
          ),
          // Centered logo and project name with animations
          Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Logo with scaling, fading, and rotating effect
                FadeTransition(
                  opacity: _fadeAnimation,
                  child: ScaleTransition(
                    scale: _scaleAnimation,
                    child: RotationTransition(
                      turns: _rotateAnimation,
                      child: Image.asset('assets/logo.png', width: 180),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                // Project name with bold text style and smooth fade effect
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
*/
