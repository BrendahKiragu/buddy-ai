import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:buddy_ai/theme.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.go('/'),
        ),
        title: const Text('About Buddy AI'),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: AppSpacing.paddingLg,
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 800),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Icon(
                      Icons.favorite,
                      size: 80,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                  const SizedBox(height: AppSpacing.xl),
                  Text(
                    'About Buddy AI',
                    style: context.textStyles.headlineLarge?.bold,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: AppSpacing.lg),
                  Text(
                    'Your Mental Health Safe Space',
                    style: context.textStyles.titleLarge?.copyWith(
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                  const SizedBox(height: AppSpacing.md),
                  Text(
                    'Buddy AI is a compassionate online platform dedicated to promoting mental health and well-being. We understand that mental health is just as important as physical health, and everyone deserves a safe, supportive space to share their experiences and seek help.',
                    style: context.textStyles.bodyLarge,
                  ),
                  const SizedBox(height: AppSpacing.xl),
                  Text(
                    'Our Mission',
                    style: context.textStyles.titleLarge?.semiBold,
                  ),
                  const SizedBox(height: AppSpacing.md),
                  Text(
                    'Our mission is to break down the barriers and stigma surrounding mental health by providing accessible, anonymous support through community-driven discussions and expert-curated content. We believe that no one should face mental health challenges alone.',
                    style: context.textStyles.bodyLarge,
                  ),
                  const SizedBox(height: AppSpacing.xl),
                  Text(
                    'What We Offer',
                    style: context.textStyles.titleLarge?.semiBold,
                  ),
                  const SizedBox(height: AppSpacing.lg),
                  InfoCard(
                    icon: Icons.forum,
                    title: 'Secret Chats',
                    description: 'Participate in anonymous, topic-based discussions where you can share your experiences, seek advice, and support others without judgment. Your privacy and anonymity are our top priorities.',
                  ),
                  const SizedBox(height: AppSpacing.md),
                  InfoCard(
                    icon: Icons.article,
                    title: 'Mental Health Blog',
                    description: 'Access a wealth of expert-written articles covering various mental health topics, from anxiety and depression to mindfulness and self-care strategies.',
                  ),
                  const SizedBox(height: AppSpacing.md),
                  InfoCard(
                    icon: Icons.group,
                    title: 'Supportive Community',
                    description: 'Connect with others who understand what you\'re going through. Our community is built on empathy, respect, and mutual support.',
                  ),
                  const SizedBox(height: AppSpacing.xl),
                  Text(
                    'Important Note',
                    style: context.textStyles.titleLarge?.semiBold,
                  ),
                  const SizedBox(height: AppSpacing.md),
                  Container(
                    padding: AppSpacing.paddingLg,
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.primaryContainer,
                      borderRadius: BorderRadius.circular(AppRadius.md),
                    ),
                    child: Text(
                      'While Buddy AI provides a supportive community and educational resources, we are not a substitute for professional mental health care. If you are experiencing a mental health crisis or need immediate help, please contact a mental health professional or crisis helpline in your area.',
                      style: context.textStyles.bodyMedium,
                    ),
                  ),
                  const SizedBox(height: AppSpacing.xl),
                  Text(
                    'Join Our Community',
                    style: context.textStyles.titleLarge?.semiBold,
                  ),
                  const SizedBox(height: AppSpacing.md),
                  Text(
                    'Creating an account is free and gives you access to all our features, including Secret Chats. Join us today and take the first step toward prioritizing your mental health.',
                    style: context.textStyles.bodyLarge,
                  ),
                  const SizedBox(height: AppSpacing.xl),
                  Center(
                    child: ElevatedButton(
                      onPressed: () => context.go('/signup'),
                      child: const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 24),
                        child: Text('Get Started'),
                      ),
                    ),
                  ),
                  const SizedBox(height: AppSpacing.xxl),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class InfoCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String description;

  const InfoCard({
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
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(icon, size: 32, color: Theme.of(context).colorScheme.primary),
            const SizedBox(width: AppSpacing.md),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: context.textStyles.titleMedium?.semiBold),
                  const SizedBox(height: AppSpacing.sm),
                  Text(description, style: context.textStyles.bodyMedium),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
