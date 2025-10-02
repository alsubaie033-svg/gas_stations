import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

// Assuming these are defined elsewhere
import '../controllers/splash_controller.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final size = MediaQuery.of(context).size;

    // --- Color Palette for Gas/Fuel Theme ---
    const Color primaryBlue = Color(0xFF0077B6); // Deep Blue
    const Color secondaryCyan = Color(0xFF48CAE4); // Bright Cyan

    return GetBuilder<SplashController>(
      builder: (controller) {
        return Scaffold(
          // Set background color to a darker shade of blue for contrast
          backgroundColor: primaryBlue,
          body: Stack(
            fit: StackFit.expand,
            children: [
              // Top swirling background effect
              Positioned(
                top: -size.height * 0.2,
                left: -size.width * 0.1,
                child: Transform.rotate(
                  angle: -0.3,
                  child: Container(
                    width: size.width * 0.8,
                    height: size.height * 0.8,
                    decoration: BoxDecoration(
                      gradient: RadialGradient(
                        colors: [
                          secondaryCyan.withOpacity(0.3),
                          Colors.transparent,
                        ],
                      ),
                    ),
                  ),
                ),
              ),

              // Main content
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Stack(
                    alignment: Alignment.center,
                    children: [
                      // Pulsing circle animation (Blue theme)
                      AnimatedBuilder(
                        animation: controller.animationController,
                        builder: (context, child) {
                          return Transform.scale(
                            scale: 1 + controller.animation.value * 0.2,
                            child: Container(
                              width: 200,
                              height: 200,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                gradient: RadialGradient(
                                  colors: [
                                    secondaryCyan.withOpacity(0.3),
                                    Colors.transparent,
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      ),

                      // Gas Pump Image
                      // Ensure you have added 'assets/gas_pump.png' to your pubspec.yaml
                      Container(
                        width: 100,
                        height: 100,
                        // Optional: Circle background for the icon
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: secondaryCyan,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.2),
                              blurRadius: 10,
                              offset: const Offset(4, 4),
                            ),
                          ],
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Image.asset(
                            'assets/gas_pump.png', // The required asset path
                            width: 80,
                            height: 80,
                            // Tint the image color for the theme
                            color: primaryBlue,
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 40),

                  // Animated text (App Name)
                  AnimatedTextKit(
                    animatedTexts: [
                      FadeAnimatedText(
                        'Fuel Finder', // Changed text
                        textStyle: theme.textTheme.displayLarge?.copyWith(
                          fontSize: 36,
                          fontWeight: FontWeight.w900,
                          letterSpacing: 1.5,
                          color: Colors.white, // Set text color to white
                          shadows: [
                            Shadow(
                              color: Colors.black.withOpacity(0.3),
                              blurRadius: 10,
                              offset: const Offset(2, 2),
                            ),
                          ],
                        ),
                      ),
                    ],
                    isRepeatingAnimation: false,
                  ),

                  const SizedBox(height: 10),

                  // Subtitle (Uncommented and styled for the new theme)
                  Text(
                    'Your Next Pit Stop', // Changed subtitle
                    style: theme.textTheme.titleLarge?.copyWith(
                      color: Colors.white70,
                      letterSpacing: 1.2,
                      fontWeight: FontWeight.w300,
                    ),
                  ),

                  const SizedBox(height: 40),

                  // Custom progress indicator (Blue gradient)
                  Container(
                    width: 120,
                    height: 3,
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: LayoutBuilder(
                      builder: (context, constraints) {
                        return AnimatedContainer(
                          duration: const Duration(seconds: 2),
                          curve: Curves.easeInOut,
                          width: constraints.maxWidth * controller.progress,
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [secondaryCyan, primaryBlue],
                            ),
                            borderRadius: BorderRadius.circular(10),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),

              // Bottom wave design
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: CustomPaint(
                  size: Size(size.width, 100),
                  painter: _WavePainter(primaryBlue: primaryBlue), // Pass color
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

// Wave Painter updated to use the primary blue color
class _WavePainter extends CustomPainter {
  final Color primaryBlue;

  _WavePainter({required this.primaryBlue});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = primaryBlue
          .withOpacity(0.4) // Use primary blue
      ..style = PaintingStyle.fill;

    final path = Path()
      ..moveTo(0, size.height)
      ..quadraticBezierTo(
        size.width * 0.25,
        size.height - 40,
        size.width * 0.5,
        size.height - 20,
      )
      ..quadraticBezierTo(
        size.width * 0.75,
        size.height,
        size.width,
        size.height - 30,
      )
      ..lineTo(size.width, size.height)
      ..lineTo(0, size.height);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
