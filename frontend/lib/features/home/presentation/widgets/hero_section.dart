import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'floating_element.dart';
import 'action_button.dart';

class HeroSection extends StatefulWidget {
  const HeroSection({super.key});

  @override
  State<HeroSection> createState() => _HeroSectionState();
}

class _HeroSectionState extends State<HeroSection>
    with TickerProviderStateMixin {
  late AnimationController _floatingController;
  late AnimationController _pulseController;
  late AnimationController _slideController;
  late Animation<double> _floatingAnimation;
  late Animation<double> _pulseAnimation;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _floatingController = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    )..repeat(reverse: true);

    _pulseController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    )..repeat(reverse: true);

    _slideController = AnimationController(
      duration: const Duration(milliseconds: 2000),
      vsync: this,
    );

    _floatingAnimation = Tween<double>(begin: -10, end: 10).animate(
      CurvedAnimation(parent: _floatingController, curve: Curves.easeInOut),
    );

    _pulseAnimation = Tween<double>(begin: 1.0, end: 1.1).animate(
      CurvedAnimation(parent: _pulseController, curve: Curves.easeInOut),
    );

    _slideAnimation =
        Tween<Offset>(begin: const Offset(0, 0.3), end: Offset.zero).animate(
          CurvedAnimation(parent: _slideController, curve: Curves.elasticOut),
        );

    _slideController.forward();
  }

  @override
  void dispose() {
    _floatingController.dispose();
    _pulseController.dispose();
    _slideController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Animated title with floating effect
        AnimatedBuilder(
          animation: _floatingAnimation,
          builder: (context, child) {
            return Transform.translate(
              offset: Offset(0, _floatingAnimation.value),
              child: AnimatedTextKit(
                animatedTexts: [
                  TypewriterAnimatedText(
                    'Share Flutter Apps as PWAs',
                    textStyle: TextStyle(
                      fontSize: 48,
                      fontWeight: FontWeight.bold,
                      height: 1.2,
                      color: Theme.of(context).colorScheme.onSurface,
                    ),
                    speed: const Duration(milliseconds: 100),
                  ),
                ],
                totalRepeatCount: 1,
                displayFullTextOnTap: true,
              ),
            );
          },
        ),

        const SizedBox(height: 24),

        // Animated subtitle
        SlideTransition(
          position: _slideAnimation,
          child: FadeTransition(
            opacity: Tween<double>(
              begin: 0.0,
              end: 1.0,
            ).animate(_slideController),
            child: const Text(
              'Deploy your Flutter web apps instantly with shareable links. No complex setup, no server management.',
              style: TextStyle(fontSize: 20, color: Colors.grey, height: 1.5),
              textAlign: TextAlign.center,
            ),
          ),
        ),

        const SizedBox(height: 60),

        // Interactive demo section
        AnimatedBuilder(
          animation: _pulseAnimation,
          builder: (context, child) {
            return Transform.scale(
              scale: _pulseAnimation.value,
              child: Container(
                height: 400,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25),
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      Theme.of(context).colorScheme.primary.withOpacity(0.1),
                      Theme.of(context).colorScheme.secondary.withOpacity(0.1),
                      Theme.of(context).colorScheme.surface,
                    ],
                  ),
                  border: Border.all(
                    color: Theme.of(
                      context,
                    ).colorScheme.primary.withOpacity(0.2),
                    width: 2,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Theme.of(
                        context,
                      ).colorScheme.primary.withOpacity(0.1),
                      blurRadius: 20,
                      offset: const Offset(0, 10),
                    ),
                  ],
                ),
                child: Stack(
                  children: [
                    // Floating elements
                    Positioned(
                      top: 50,
                      left: 50,
                      child: FloatingElement(
                        icon: Icons.rocket_launch,
                        color: Colors.blue,
                        label: 'Deploy',
                        animation: _floatingAnimation,
                      ),
                    ),
                    Positioned(
                      top: 100,
                      right: 80,
                      child: FloatingElement(
                        icon: Icons.share,
                        color: Colors.green,
                        label: 'Share',
                        animation: _floatingAnimation,
                      ),
                    ),
                    Positioned(
                      bottom: 80,
                      left: 100,
                      child: FloatingElement(
                        icon: Icons.security,
                        color: Colors.orange,
                        label: 'Secure',
                        animation: _floatingAnimation,
                      ),
                    ),
                    Positioned(
                      bottom: 120,
                      right: 60,
                      child: FloatingElement(
                        icon: Icons.speed,
                        color: Colors.purple,
                        label: 'Fast',
                        animation: _floatingAnimation,
                      ),
                    ),

                    // Center content
                    Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            width: 120,
                            height: 120,
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [
                                  Theme.of(context).colorScheme.primary,
                                  Theme.of(context).colorScheme.secondary,
                                ],
                              ),
                              shape: BoxShape.circle,
                              boxShadow: [
                                BoxShadow(
                                  color: Theme.of(
                                    context,
                                  ).colorScheme.primary.withOpacity(0.3),
                                  blurRadius: 20,
                                  offset: const Offset(0, 10),
                                ),
                              ],
                            ),
                            child: const Icon(
                              Icons.play_arrow,
                              color: Colors.white,
                              size: 60,
                            ),
                          ),
                          const SizedBox(height: 20),
                          Text(
                            'Try Demo',
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Theme.of(context).colorScheme.onSurface,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'Click to see Freeze in action',
                            style: TextStyle(
                              fontSize: 16,
                              color: Theme.of(
                                context,
                              ).colorScheme.onSurface.withOpacity(0.7),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),

        const SizedBox(height: 40),

        // Call to action buttons
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ActionButton(
              text: 'Get Started',
              icon: Icons.rocket_launch,
              color: Theme.of(context).colorScheme.primary,
              onTap: () {
                // TODO: Navigate to signup
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Sign up coming soon!')),
                );
              },
            ),
            const SizedBox(width: 20),
            ActionButton(
              text: 'Learn More',
              icon: Icons.info_outline,
              color: Colors.transparent,
              onTap: () {
                // TODO: Navigate to docs
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Documentation coming soon!')),
                );
              },
              isOutlined: true,
            ),
          ],
        ),
      ],
    );
  }
}
