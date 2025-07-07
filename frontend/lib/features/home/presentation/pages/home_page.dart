import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:freeze/core/routing/routes.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Freeze'),
        actions: [
          TextButton(
            onPressed: () => context.go(Routes.login),
            child: const Text('Login'),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 48),
            const Text(
              'Share Flutter Apps as PWAs',
              style: TextStyle(fontSize: 48, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            const Text(
              'Deploy your Flutter web apps instantly with shareable links. No complex setup, no server management.',
              style: TextStyle(fontSize: 20, color: Colors.grey),
            ),
            const SizedBox(height: 48),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () => context.go(Routes.login),
                    child: const Text('Get Started'),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: OutlinedButton(
                    onPressed: () {
                      // TODO: Add documentation link
                    },
                    child: const Text('Learn More'),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 80),
            const Text(
              'Features',
              style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 32),
            const FeatureCard(
              icon: Icons.rocket_launch,
              title: 'Instant Deployment',
              description: 'Deploy your Flutter web apps with a single click.',
            ),
            const SizedBox(height: 16),
            const FeatureCard(
              icon: Icons.share,
              title: 'Shareable Links',
              description:
                  'Get a unique URL for your app that anyone can access.',
            ),
            const SizedBox(height: 16),
            const FeatureCard(
              icon: Icons.security,
              title: 'Secure & Reliable',
              description:
                  'Built on proven infrastructure with automatic scaling.',
            ),
          ],
        ),
      ),
    );
  }
}

class FeatureCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String description;

  const FeatureCard({
    super.key,
    required this.icon,
    required this.title,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Row(
          children: [
            Icon(icon, size: 48, color: Colors.blue),
            const SizedBox(width: 24),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    description,
                    style: const TextStyle(fontSize: 16, color: Colors.grey),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
