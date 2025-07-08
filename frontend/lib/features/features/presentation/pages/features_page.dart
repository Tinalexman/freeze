import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import '../widgets/feature_card.dart';
import '../widgets/pricing_card.dart';

class FeaturesPage extends StatefulWidget {
  const FeaturesPage({super.key});

  @override
  State<FeaturesPage> createState() => _FeaturesPageState();
}

class _FeaturesPageState extends State<FeaturesPage>
    with TickerProviderStateMixin {
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
                                  'Features',
                                  style: TextStyle(
                                    fontSize: 32,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 20),
                            const Text(
                              'Everything you need to deploy Flutter apps as PWAs',
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

                    // Features grid
                    AnimationLimiter(
                      child: GridView.count(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        crossAxisCount: 2,
                        crossAxisSpacing: 20,
                        mainAxisSpacing: 20,
                        childAspectRatio: 1.2,
                        children: AnimationConfiguration.toStaggeredList(
                          duration: const Duration(milliseconds: 600),
                          childAnimationBuilder: (widget) => SlideAnimation(
                            horizontalOffset: 50.0,
                            child: FadeInAnimation(child: widget),
                          ),
                          children: [
                            FeatureCard(
                              icon: Icons.rocket_launch,
                              title: 'Instant Deployment',
                              description:
                                  'Deploy your Flutter web apps with a single click. No complex configuration needed.',
                              color: Colors.blue,
                            ),
                            FeatureCard(
                              icon: Icons.share,
                              title: 'Shareable Links',
                              description:
                                  'Get a unique URL for your app that anyone can access from any device.',
                              color: Colors.green,
                            ),
                            FeatureCard(
                              icon: Icons.security,
                              title: 'Secure & Reliable',
                              description:
                                  'Built on proven infrastructure with automatic scaling and 99.9% uptime.',
                              color: Colors.orange,
                            ),
                            FeatureCard(
                              icon: Icons.speed,
                              title: 'Lightning Fast',
                              description:
                                  'Optimized for performance with CDN distribution and edge caching.',
                              color: Colors.purple,
                            ),
                            FeatureCard(
                              icon: Icons.devices,
                              title: 'Cross-Platform',
                              description:
                                  'Works seamlessly across all devices - desktop, tablet, and mobile.',
                              color: Colors.teal,
                            ),
                            FeatureCard(
                              icon: Icons.analytics,
                              title: 'Analytics & Insights',
                              description:
                                  'Track usage, performance metrics, and user engagement with built-in analytics.',
                              color: Colors.indigo,
                            ),
                          ],
                        ),
                      ),
                    ),

                    const SizedBox(height: 80),

                    // Pricing section
                    FadeTransition(
                      opacity: _fadeAnimation,
                      child: Column(
                        children: [
                          const Text(
                            'Simple Pricing',
                            style: TextStyle(
                              fontSize: 28,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 40),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              PricingCard(
                                title: 'Free',
                                price: '\$0',
                                subtitle: 'Perfect for getting started',
                                features: [
                                  'Up to 3 projects',
                                  'Basic analytics',
                                  'Community support',
                                ],
                                color: Colors.grey,
                              ),
                              const SizedBox(width: 20),
                              PricingCard(
                                title: 'Pro',
                                price: '\$9',
                                subtitle: 'For serious developers',
                                features: [
                                  'Unlimited projects',
                                  'Advanced analytics',
                                  'Priority support',
                                  'Custom domains',
                                ],
                                color: Theme.of(context).colorScheme.primary,
                                isPopular: true,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 80),

                    // CTA
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
                              'Ready to get started?',
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 16),
                            const Text(
                              'Join thousands of developers who trust Freeze for their Flutter app deployments.',
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.grey,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(height: 30),
                            ElevatedButton(
                              onPressed: () {
                                // TODO: Navigate to signup
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text('Sign up coming soon!'),
                                  ),
                                );
                              },
                              style: ElevatedButton.styleFrom(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 32,
                                  vertical: 16,
                                ),
                                backgroundColor: Theme.of(
                                  context,
                                ).colorScheme.primary,
                                foregroundColor: Colors.white,
                              ),
                              child: const Text(
                                'Get Started Now',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
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
