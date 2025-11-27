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
    final width = MediaQuery.of(context).size.width;
    final isSmall = width < 700;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Buddy AI',
          style: context.textStyles.titleLarge?.copyWith(
            color: Theme.of(context).colorScheme.primary,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: isSmall
            ? null
            : [
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
                  const SizedBox(width: AppSpacing.sm),
                ] else ...[
                  OutlinedButton(
                    onPressed: () => context.go('/login'),
                    child: const Text('Login'),
                  ),
                  const SizedBox(width: AppSpacing.sm),
                  ElevatedButton(
                    onPressed: () => context.go('/signup'),
                    child: const Text('Sign Up'),
                  ),
                  const SizedBox(width: AppSpacing.sm),
                ],
              ],
      ),
      drawer: isSmall
          ? Drawer(
              child: SafeArea(
                child: ListView(
                  padding: EdgeInsets.zero,
                  children: [
                    DrawerHeader(
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.primaryContainer,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            'Buddy AI',
                            style: context.textStyles.headlineSmall?.copyWith(
                              color: Theme.of(context).colorScheme.primary,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: AppSpacing.xs),
                          Text(
                            'Your mental health safe space',
                            style: context.textStyles.bodyMedium?.copyWith(
                              color: Theme.of(context).colorScheme.onPrimaryContainer,
                            ),
                          ),
                        ],
                      ),
                    ),
                    ListTile(
                      leading: const Icon(Icons.info_outline, color: Colors.blue),
                      title: const Text('About'),
                      onTap: () {
                        Navigator.pop(context);
                        context.go('/about');
                      },
                    ),
                    ListTile(
                      leading: const Icon(Icons.article_outlined, color: Colors.blue),
                      title: const Text('Blog'),
                      onTap: () {
                        Navigator.pop(context);
                        context.go('/blogs');
                      },
                    ),
                    if (isLoggedIn)
                      ListTile(
                        leading: const Icon(Icons.forum_outlined, color: Colors.blue),
                        title: const Text('Secret Chats'),
                        onTap: () {
                          Navigator.pop(context);
                          context.go('/secret-chats');
                        },
                      ),
                    const Divider(height: 1),
                    if (isLoggedIn)
                      ListTile(
                        leading: const Icon(Icons.logout, color: Colors.blue),
                        title: const Text('Logout'),
                        onTap: () async {
                          Navigator.pop(context);
                          await authProvider.logout();
                          if (context.mounted) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('Logged out successfully')),
                            );
                          }
                        },
                      )
                    else ...[
                      ListTile(
                        leading: const Icon(Icons.login, color: Colors.blue),
                        title: const Text('Login'),
                        onTap: () {
                          Navigator.pop(context);
                          context.go('/login');
                        },
                      ),
                      ListTile(
                        leading: const Icon(Icons.person_add_alt_1, color: Colors.blue),
                        title: const Text('Sign Up'),
                        onTap: () {
                          Navigator.pop(context);
                          context.go('/signup');
                        },
                      ),
                    ],
                  ],
                ),
              ),
            )
          : null,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: AppSpacing.xxl),
              Container(
                margin: AppSpacing.horizontalLg,
                height: isSmall ? 260 : 400,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(AppRadius.xl),
                  image: const DecorationImage(
                    image: AssetImage('assets/images/hero.jpg'),
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
                        Colors.black.withOpacity(0.3),
                        Colors.black.withOpacity(0.7),
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
                          color: Colors.white.withOpacity(0.9),
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
                    LayoutBuilder(
                      builder: (context, constraints) {
                        final w = constraints.maxWidth;
                        final crossAxisCount = w < 600 ? 1 : (w < 1000 ? 2 : 3);
                        return GridView(
                          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: crossAxisCount,
                            crossAxisSpacing: AppSpacing.lg.toDouble(),
                            mainAxisSpacing: AppSpacing.lg.toDouble(),
                            childAspectRatio: 4 / 3,
                          ),
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          children: [
                            FeatureCard(
                              icon: Icons.forum_outlined,
                              title: 'Secret Chats',
                              description: 'Share anonymously in topic-based discussions',
                              onTap: () {
                                if (isLoggedIn) {
                                  context.go('/secret-chats');
                                } else {
                                  context.go('/login');
                                }
                              },
                            ),
                            FeatureCard(
                              icon: Icons.article_outlined,
                              title: 'Mental Health Blog',
                              description: 'Read expert articles and insights',
                              onTap: () => context.go('/blogs'),
                            ),
                            FeatureCard(
                              icon: Icons.favorite_outline,
                              title: 'Safe Community',
                              description: 'Connect with others on their journey',
                              onTap: () => context.go('/about'),
                            ),
                          ],
                        );
                      },
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
  final VoidCallback? onTap;

  const FeatureCard({
    super.key,
    required this.icon,
    required this.title,
    required this.description,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        borderRadius: BorderRadius.circular(AppRadius.lg),
        onTap: onTap,
        child: Padding(
          padding: AppSpacing.paddingLg,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 48, color: Theme.of(context).colorScheme.primary),
              const SizedBox(height: AppSpacing.md),
              Text(title, style: context.textStyles.titleLarge?.semiBold, textAlign: TextAlign.center),
              const SizedBox(height: AppSpacing.sm),
              Text(description, style: context.textStyles.bodyMedium, textAlign: TextAlign.center),
            ],
          ),
        ),
      ),
    );
  }
}
