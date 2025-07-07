import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';

class HeroSection extends StatelessWidget {
  const HeroSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Animated title
        AnimatedTextKit(
          animatedTexts: [
            TypewriterAnimatedText(
              'Share Flutter Apps as PWAs',
              textStyle: const TextStyle(
                fontSize: 48,
                fontWeight: FontWeight.bold,
                height: 1.2,
              ),
              speed: const Duration(milliseconds: 100),
            ),
          ],
          totalRepeatCount: 1,
          displayFullTextOnTap: true,
        ),

        const SizedBox(height: 24),

        // Animated subtitle
        const Text(
          'Deploy your Flutter web apps instantly with shareable links. No complex setup, no server management.',
          style: TextStyle(fontSize: 20, color: Colors.grey, height: 1.5),
          textAlign: TextAlign.center,
        ),

        const SizedBox(height: 60),

        // Rive animation placeholder
        Container(
          height: 300,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            gradient: LinearGradient(
              colors: [
                Theme.of(context).colorScheme.primary.withOpacity(0.1),
                Theme.of(context).colorScheme.secondary.withOpacity(0.1),
              ],
            ),
          ),
          child: const Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.rocket_launch, size: 80, color: Colors.blue),
                SizedBox(height: 16),
                Text(
                  '🚀 Rive Animation Placeholder',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                ),
                Text(
                  'Add your .riv file here for amazing animations!',
                  style: TextStyle(fontSize: 14, color: Colors.grey),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
