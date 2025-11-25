import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:buddy_ai/models/blog_model.dart';
import 'package:buddy_ai/services/blog_service.dart';
import 'package:buddy_ai/theme.dart';

class BlogDetailPage extends StatefulWidget {
  final String blogId;

  const BlogDetailPage({super.key, required this.blogId});

  @override
  State<BlogDetailPage> createState() => _BlogDetailPageState();
}

class _BlogDetailPageState extends State<BlogDetailPage> {
  final BlogService _blogService = BlogService();
  BlogModel? _blog;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadBlog();
  }

  Future<void> _loadBlog() async {
    await _blogService.initialize();
    final blog = await _blogService.getBlogById(widget.blogId);
    setState(() {
      _blog = blog;
      _isLoading = false;
    });
  }

  String _formatDate(DateTime dateTime) {
    final months = [
      'January', 'February', 'March', 'April', 'May', 'June',
      'July', 'August', 'September', 'October', 'November', 'December'
    ];
    return '${months[dateTime.month - 1]} ${dateTime.day}, ${dateTime.year}';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _blog == null
              ? const Center(child: Text('Blog not found'))
              : CustomScrollView(
                  slivers: [
                    SliverAppBar(
                      expandedHeight: 300,
                      pinned: true,
                      leading: IconButton(
                        icon: Container(
                          padding: const EdgeInsets.all(AppSpacing.sm),
                          decoration: BoxDecoration(
                            color: Colors.black.withValues(alpha: 0.5),
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(Icons.arrow_back, color: Colors.white),
                        ),
                        onPressed: () => context.go('/blogs'),
                      ),
                      flexibleSpace: FlexibleSpaceBar(
                        background: Image.asset(
                          _blog!.imageUrl,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) => Container(
                            color: Theme.of(context).colorScheme.primaryContainer,
                            child: Icon(
                              Icons.image_outlined,
                              size: 80,
                              color: Theme.of(context).colorScheme.primary,
                            ),
                          ),
                        ),
                      ),
                    ),
                    SliverToBoxAdapter(
                      child: Padding(
                        padding: AppSpacing.paddingLg,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: AppSpacing.md),
                            Text(
                              _blog!.title,
                              style: context.textStyles.headlineMedium?.bold,
                            ),
                            const SizedBox(height: AppSpacing.md),
                            Row(
                              children: [
                                CircleAvatar(
                                  radius: 20,
                                  backgroundColor: Theme.of(context).colorScheme.primaryContainer,
                                  child: Icon(
                                    Icons.person,
                                    color: Theme.of(context).colorScheme.primary,
                                  ),
                                ),
                                const SizedBox(width: AppSpacing.md),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Buddy AI Team',
                                      style: context.textStyles.titleSmall?.semiBold,
                                    ),
                                    Text(
                                      _formatDate(_blog!.createdAt),
                                      style: context.textStyles.bodySmall?.copyWith(
                                        color: Theme.of(context).colorScheme.onSurfaceVariant,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            const SizedBox(height: AppSpacing.xl),
                            ..._blog!.content.split('\n\n').map((paragraph) {
                              return Padding(
                                padding: const EdgeInsets.only(bottom: AppSpacing.lg),
                                child: Text(
                                  paragraph,
                                  style: context.textStyles.bodyLarge?.copyWith(height: 1.6),
                                ),
                              );
                            }),
                            const SizedBox(height: AppSpacing.xl),
                            Container(
                              padding: AppSpacing.paddingLg,
                              decoration: BoxDecoration(
                                color: Theme.of(context).colorScheme.primaryContainer,
                                borderRadius: BorderRadius.circular(AppRadius.md),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.favorite,
                                        color: Theme.of(context).colorScheme.primary,
                                      ),
                                      const SizedBox(width: AppSpacing.md),
                                      Text(
                                        'Need Support?',
                                        style: context.textStyles.titleMedium?.semiBold,
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: AppSpacing.md),
                                  Text(
                                    'If you\'re struggling with your mental health, you\'re not alone. Join our supportive community in Secret Chats or reach out to a mental health professional.',
                                    style: context.textStyles.bodyMedium,
                                  ),
                                  const SizedBox(height: AppSpacing.md),
                                  ElevatedButton(
                                    onPressed: () => context.go('/secret-chats'),
                                    child: const Text('Visit Secret Chats'),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: AppSpacing.xxl),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
    );
  }
}
