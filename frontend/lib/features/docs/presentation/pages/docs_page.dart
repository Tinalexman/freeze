import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import '../widgets/docs_section.dart';
import '../widgets/code_example.dart';
import '../widgets/api_section.dart';
import '../widgets/help_button.dart';

class DocsPage extends StatefulWidget {
  const DocsPage({super.key});

  @override
  State<DocsPage> createState() => _DocsPageState();
}

class _DocsPageState extends State<DocsPage> with TickerProviderStateMixin {
  late AnimationController _fadeController;
  late AnimationController _slideController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _fadeController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );
    _slideController = AnimationController(
      duration: const Duration(milliseconds: 1200),
      vsync: this,
    );

    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _fadeController, curve: Curves.easeOut));

    _slideAnimation =
        Tween<Offset>(begin: const Offset(0, 0.3), end: Offset.zero).animate(
          CurvedAnimation(parent: _slideController, curve: Curves.elasticOut),
        );

    _fadeController.forward();
    _slideController.forward();
  }

  @override
  void dispose() {
    _fadeController.dispose();
    _slideController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Theme.of(context).colorScheme.primary.withOpacity(0.05),
                    Theme.of(context).colorScheme.secondary.withOpacity(0.03),
                    Theme.of(context).colorScheme.surface,
                  ],
                ),
              ),
            ),
          ),

          // Content
          SafeArea(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  children: [
                    // Header
                    FadeTransition(
                      opacity: _fadeAnimation,
                      child: SlideTransition(
                        position: _slideAnimation,
                        child: Column(
                          children: [
                            Row(
                              children: [
                                IconButton(
                                  onPressed: () => Navigator.pop(context),
                                  icon: const Icon(Icons.arrow_back),
                                ),
                                const SizedBox(width: 16),
                                const Text(
                                  'Documentation',
                                  style: TextStyle(
                                    fontSize: 32,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 20),
                            const Text(
                              'Learn how to deploy your Flutter apps with Freeze',
                              style: TextStyle(
                                fontSize: 18,
                                color: Colors.grey,
                                height: 1.5,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
                    ),

                    const SizedBox(height: 60),

                    // Quick start section
                    AnimationLimiter(
                      child: Column(
                        children: AnimationConfiguration.toStaggeredList(
                          duration: const Duration(milliseconds: 600),
                          childAnimationBuilder: (widget) => SlideAnimation(
                            verticalOffset: 50.0,
                            child: FadeInAnimation(child: widget),
                          ),
                          children: [
                            DocsSection(
                              title: 'Quick Start',
                              icon: Icons.rocket_launch,
                              color: Colors.blue,
                              steps: [
                                '1. Create a new Flutter web project',
                                '2. Build your app for web',
                                '3. Upload to Freeze',
                                '4. Share your app link',
                              ],
                            ),
                            const SizedBox(height: 30),
                            DocsSection(
                              title: 'Getting Started',
                              icon: Icons.school,
                              color: Colors.green,
                              steps: [
                                'Install Flutter SDK',
                                'Create a new project',
                                'Add web support',
                                'Build for production',
                              ],
                            ),
                            const SizedBox(height: 30),
                            DocsSection(
                              title: 'Deployment',
                              icon: Icons.cloud_upload,
                              color: Colors.orange,
                              steps: [
                                'Upload your build files',
                                'Configure app settings',
                                'Deploy with one click',
                                'Get your shareable link',
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),

                    const SizedBox(height: 60),

                    // Code examples
                    FadeTransition(
                      opacity: _fadeAnimation,
                      child: Column(
                        children: [
                          const Text(
                            'Code Examples',
                            style: TextStyle(
                              fontSize: 28,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 30),
                          CodeExample(
                            title: 'pubspec.yaml',
                            code: '''
dependencies:
  flutter:
    sdk: flutter
  cupertino_icons: ^1.0.2

dev_dependencies:
  flutter_test:
    sdk: flutter
  flutter_lints: ^2.0.0
''',
                          ),
                          const SizedBox(height: 20),
                          CodeExample(
                            title: 'Build Command',
                            code: '''
flutter build web --release
''',
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 60),

                    // API Reference
                    FadeTransition(
                      opacity: _fadeAnimation,
                      child: Column(
                        children: [
                          const Text(
                            'API Reference',
                            style: TextStyle(
                              fontSize: 28,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 30),
                          ApiSection(
                            title: 'Authentication',
                            description:
                                'Learn how to authenticate with the Freeze API',
                            icon: Icons.security,
                            color: Colors.purple,
                          ),
                          const SizedBox(height: 20),
                          ApiSection(
                            title: 'Deployment API',
                            description:
                                'Deploy apps programmatically using our REST API',
                            icon: Icons.api,
                            color: Colors.teal,
                          ),
                          const SizedBox(height: 20),
                          ApiSection(
                            title: 'Webhooks',
                            description:
                                'Receive notifications when deployments complete',
                            icon: Icons.webhook,
                            color: Colors.indigo,
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 80),

                    // Help section
                    FadeTransition(
                      opacity: _fadeAnimation,
                      child: Container(
                        padding: const EdgeInsets.all(40),
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              Theme.of(
                                context,
                              ).colorScheme.primary.withOpacity(0.1),
                              Theme.of(
                                context,
                              ).colorScheme.secondary.withOpacity(0.1),
                            ],
                          ),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Column(
                          children: [
                            const Text(
                              'Need Help?',
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 16),
                            const Text(
                              'Can\'t find what you\'re looking for? Our team is here to help.',
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.grey,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(height: 30),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                HelpButton(
                                  text: 'Contact Support',
                                  icon: Icons.support_agent,
                                  onTap: () {
                                    // TODO: Navigate to contact
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        content: Text(
                                          'Contact page coming soon!',
                                        ),
                                      ),
                                    );
                                  },
                                ),
                                const SizedBox(width: 20),
                                HelpButton(
                                  text: 'Community',
                                  icon: Icons.forum,
                                  onTap: () {
                                    // TODO: Navigate to community
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        content: Text(
                                          'Community page coming soon!',
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
