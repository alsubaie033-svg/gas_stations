import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/splash_controller.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final size = MediaQuery.of(context).size;

    return GetBuilder<SplashController>(builder: (controller) {
      return Scaffold(
        body: Stack(
          fit: StackFit.expand,
          children: [
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
                        Colors.red.shade900.withOpacity(0.3),
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
                    // Pulsing circle animation
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
                                  Colors.red.shade800.withOpacity(0.3),
                                  Colors.transparent,
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),

                    // Blood drop icon with shadow
                    ShaderMask(
                      blendMode: BlendMode.srcIn,
                      shaderCallback: (bounds) => LinearGradient(
                        colors: [
                          Colors.red.shade400,
                          Colors.red.shade900,
                        ],
                      ).createShader(bounds),
                      child: const Icon(
                        Icons.favorite,
                        size: 80,
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 40),

                // Animated text
                AnimatedTextKit(
                  animatedTexts: [
                    FadeAnimatedText(
                      'LifeStream',
                      textStyle: theme.textTheme.displayLarge?.copyWith(
                        fontSize: 36,
                        fontWeight: FontWeight.w900,
                        letterSpacing: 1.5,
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

                // Subtitle with sliding animation
                // SlideInDown(
                //   child: Text(
                //     'Connecting Donors & Recipients',
                //     style: theme.textTheme.titleLarge?.copyWith(
                //       color: Colors.white70,
                //       letterSpacing: 1.2,
                //       fontWeight: FontWeight.w300,
                //     ),
                //   ),
                // ),

                const SizedBox(height: 40),

                // Custom progress indicator
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
                            colors: [
                              Colors.red.shade400,
                              Colors.red.shade800,
                            ],
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
                painter: _WavePainter(),
              ),
            ),
          ],
        ),
      );
    });
  }
}

class _WavePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.red.shade800.withOpacity(0.4)
      ..style = PaintingStyle.fill;

    final path = Path()
      ..moveTo(0, size.height)
      ..quadraticBezierTo(size.width * 0.25, size.height - 40, size.width * 0.5,
          size.height - 20)
      ..quadraticBezierTo(
          size.width * 0.75, size.height, size.width, size.height - 30)
      ..lineTo(size.width, size.height)
      ..lineTo(0, size.height);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
