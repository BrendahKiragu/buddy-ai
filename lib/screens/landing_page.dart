import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:buddy_ai/theme.dart';
import 'package:provider/provider.dart';
import 'package:buddy_ai/providers/auth_provider.dart';

class LandingPage extends StatelessWidget {
  const LandingPage({super.key});

  @override
  Widget build(BuildContext context) {
    final authProvider = context.watch<AuthProvider>();
    final isLoggedIn = authProvider.isLoggedIn;

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: AppSpacing.lg),
              Padding(
                padding: AppSpacing.horizontalLg,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Buddy AI', style: context.textStyles.headlineMedium?.copyWith(color: Theme.of(context).colorScheme.primary, fontWeight: FontWeight.bold)),
                    Row(
                      children: [
                        TextButton(
                          onPressed: () => context.go('/about'),
                          child: const Text('About'),
                        ),
                        const SizedBox(width: AppSpacing.sm),
                        TextButton(
                          onPressed: () => context.go('/blogs'),
                          child: const Text('Blog'),
                        ),
                        const SizedBox(width: AppSpacing.sm),
                        if (isLoggedIn) ...[
                          TextButton(
                            onPressed: () => context.go('/secret-chats'),
                            child: const Text('Secret Chats'),
                          ),
                          const SizedBox(width: AppSpacing.sm),
                          OutlinedButton(
                            onPressed: () async {
                              await authProvider.logout();
                              if (context.mounted) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(content: Text('Logged out successfully')),
                                );
                              }
                            },
                            child: const Text('Logout'),
                          ),
                        ] else ...[
                          OutlinedButton(
                            onPressed: () => context.go('/login'),
                            child: const Text('Login'),
                          ),
                        ],
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: AppSpacing.xxl),
              Container(
                margin: AppSpacing.horizontalLg,
                height: 400,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(AppRadius.xl),
                  image: const DecorationImage(
                    image: AssetImage('assets/images/buddy1.jpg'),
                    fit: BoxFit.cover,
                  ),
                ),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(AppRadius.xl),
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.black.withValues(alpha: 0.3),
                        Colors.black.withValues(alpha: 0.7),
                      ],
                    ),
                  ),
                  padding: AppSpacing.paddingXl,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Buddy AI',
                        style: context.textStyles.displayMedium?.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: AppSpacing.md),
                      Text(
                        'Your mental health safe space',
                        style: context.textStyles.headlineSmall?.copyWith(
                          color: Colors.white.withValues(alpha: 0.9),
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: AppSpacing.xl),
                      if (!isLoggedIn)
                        ElevatedButton(
                          onPressed: () => context.go('/signup'),
                          child: const Padding(
                            padding: EdgeInsets.symmetric(horizontal: 32, vertical: 8),
                            child: Text('Get Started', style: TextStyle(fontSize: 18)),
                          ),
                        ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: AppSpacing.xxl),
              Padding(
                padding: AppSpacing.horizontalLg,
                child: Column(
                  children: [
                    Text(
                      'A safe space for your mental well-being',
                      style: context.textStyles.headlineMedium?.semiBold,
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: AppSpacing.xl),
                    Row(
                      children: [
                        Expanded(
                          child: FeatureCard(
                            icon: Icons.forum_outlined,
                            title: 'Secret Chats',
                            description: 'Share anonymously in topic-based discussions',
                          ),
                        ),
                        const SizedBox(width: AppSpacing.lg),
                        Expanded(
                          child: FeatureCard(
                            icon: Icons.article_outlined,
                            title: 'Mental Health Blog',
                            description: 'Read expert articles and insights',
                          ),
                        ),
                        const SizedBox(width: AppSpacing.lg),
                        Expanded(
                          child: FeatureCard(
                            icon: Icons.favorite_outline,
                            title: 'Safe Community',
                            description: 'Connect with others on their journey',
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: AppSpacing.xxl),
            ],
          ),
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
        padding: AppSpacing.paddingLg,
        child: Column(
          children: [
            Icon(icon, size: 48, color: Theme.of(context).colorScheme.primary),
            const SizedBox(height: AppSpacing.md),
            Text(title, style: context.textStyles.titleLarge?.semiBold, textAlign: TextAlign.center),
            const SizedBox(height: AppSpacing.sm),
            Text(description, style: context.textStyles.bodyMedium, textAlign: TextAlign.center),
          ],
        ),
      ),
    );
  }
}
