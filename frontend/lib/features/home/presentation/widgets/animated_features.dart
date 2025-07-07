import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'feature_card.dart';

class AnimatedFeatures extends StatelessWidget {
  const AnimatedFeatures({super.key});

  @override
  Widget build(BuildContext context) {
    final features = [
      {
        'icon': Icons.rocket_launch,
        'title': 'Instant Deployment',
        'description': 'Deploy your Flutter web apps with a single click.',
        'color': Colors.blue,
      },
      {
        'icon': Icons.share,
        'title': 'Shareable Links',
        'description': 'Get a unique URL for your app that anyone can access.',
        'color': Colors.green,
      },
      {
        'icon': Icons.security,
        'title': 'Secure & Reliable',
        'description': 'Built on proven infrastructure with automatic scaling.',
        'color': Colors.orange,
      },
    ];

    return AnimationLimiter(
      child: Column(
        children: AnimationConfiguration.toStaggeredList(
          duration: const Duration(milliseconds: 600),
          childAnimationBuilder: (widget) => SlideAnimation(
            horizontalOffset: 50.0,
            child: FadeInAnimation(child: widget),
          ),
          children: [
            const Text(
              'Features',
              style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 40),
            ...features.map(
              (feature) => FeatureCard(
                icon: feature['icon'] as IconData,
                title: feature['title'] as String,
                description: feature['description'] as String,
                color: feature['color'] as Color,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
