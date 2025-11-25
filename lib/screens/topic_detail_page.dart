import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:buddy_ai/models/comment_model.dart';
import 'package:buddy_ai/models/topic_model.dart';
import 'package:buddy_ai/services/topic_service.dart';
import 'package:buddy_ai/theme.dart';
import 'package:provider/provider.dart';
import 'package:buddy_ai/providers/auth_provider.dart';

class TopicDetailPage extends StatefulWidget {
  final String topicId;

  const TopicDetailPage({super.key, required this.topicId});

  @override
  State<TopicDetailPage> createState() => _TopicDetailPageState();
}

class _TopicDetailPageState extends State<TopicDetailPage> {
  final TopicService _topicService = TopicService();
  final TextEditingController _commentController = TextEditingController();
  TopicModel? _topic;
  List<CommentModel> _comments = [];
  bool _isLoading = true;
  bool _isSubmitting = false;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  @override
  void dispose() {
    _commentController.dispose();
    super.dispose();
  }

  Future<void> _loadData() async {
    await _topicService.initialize();
    final topic = await _topicService.getTopicById(widget.topicId);
    final comments = await _topicService.getCommentsByTopicId(widget.topicId);
    setState(() {
      _topic = topic;
      _comments = comments;
      _isLoading = false;
    });
  }

  Future<void> _submitComment() async {
    if (_commentController.text.trim().isEmpty) return;

    final authProvider = context.read<AuthProvider>();
    if (authProvider.currentUser == null) return;

    setState(() => _isSubmitting = true);

    final newComment = CommentModel(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      topicId: widget.topicId,
      userId: authProvider.currentUser!.id,
      content: _commentController.text.trim(),
      isAnonymous: true,
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    );

    await _topicService.addComment(newComment);
    _commentController.clear();
    await _loadData();

    setState(() => _isSubmitting = false);

    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Comment posted anonymously')),
      );
    }
  }

  String _getTimeAgo(DateTime dateTime) {
    final now = DateTime.now();
    final difference = now.difference(dateTime);

    if (difference.inDays > 0) {
      return '${difference.inDays}d ago';
    } else if (difference.inHours > 0) {
      return '${difference.inHours}h ago';
    } else if (difference.inMinutes > 0) {
      return '${difference.inMinutes}m ago';
    } else {
      return 'Just now';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.go('/secret-chats'),
        ),
        title: const Text('Discussion'),
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _topic == null
              ? const Center(child: Text('Topic not found'))
              : Column(
                  children: [
                    Container(
                      padding: AppSpacing.paddingLg,
                      color: Theme.of(context).colorScheme.primaryContainer,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            _topic!.title,
                            style: context.textStyles.titleLarge?.bold,
                          ),
                          const SizedBox(height: AppSpacing.sm),
                          Row(
                            children: [
                              Icon(
                                Icons.comment_outlined,
                                size: 16,
                                color: Theme.of(context).colorScheme.onPrimaryContainer,
                              ),
                              const SizedBox(width: AppSpacing.xs),
                              Text(
                                '${_comments.length} comments',
                                style: context.textStyles.bodySmall?.copyWith(
                                  color: Theme.of(context).colorScheme.onPrimaryContainer,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: _comments.isEmpty
                          ? Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.comment_outlined,
                                    size: 48,
                                    color: Theme.of(context).colorScheme.primary.withValues(alpha: 0.5),
                                  ),
                                  const SizedBox(height: AppSpacing.md),
                                  Text(
                                    'No comments yet',
                                    style: context.textStyles.titleMedium,
                                  ),
                                  const SizedBox(height: AppSpacing.sm),
                                  Text(
                                    'Be the first to share',
                                    style: context.textStyles.bodyMedium,
                                  ),
                                ],
                              ),
                            )
                          : ListView.builder(
                              padding: AppSpacing.paddingLg,
                              itemCount: _comments.length,
                              itemBuilder: (context, index) {
                                final comment = _comments[index];
                                return CommentCard(
                                  comment: comment,
                                  timeAgo: _getTimeAgo(comment.createdAt),
                                );
                              },
                            ),
                    ),
                    Container(
                      padding: AppSpacing.paddingLg,
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.surface,
                        border: Border(
                          top: BorderSide(
                            color: Theme.of(context).colorScheme.outline.withValues(alpha: 0.2),
                          ),
                        ),
                      ),
                      child: SafeArea(
                        child: Row(
                          children: [
                            Expanded(
                              child: TextField(
                                controller: _commentController,
                                decoration: InputDecoration(
                                  hintText: 'Share your thoughts anonymously...',
                                  prefixIcon: const Icon(Icons.lock_outline),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(AppRadius.md),
                                  ),
                                ),
                                maxLines: null,
                                textInputAction: TextInputAction.send,
                                onSubmitted: (_) => _submitComment(),
                              ),
                            ),
                            const SizedBox(width: AppSpacing.md),
                            IconButton(
                              onPressed: _isSubmitting ? null : _submitComment,
                              icon: _isSubmitting
                                  ? const SizedBox(
                                      width: 20,
                                      height: 20,
                                      child: CircularProgressIndicator(strokeWidth: 2),
                                    )
                                  : Icon(
                                      Icons.send,
                                      color: Theme.of(context).colorScheme.primary,
                                    ),
                              style: IconButton.styleFrom(
                                backgroundColor: Theme.of(context).colorScheme.primaryContainer,
                                padding: const EdgeInsets.all(AppSpacing.md),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
    );
  }
}

class CommentCard extends StatelessWidget {
  final CommentModel comment;
  final String timeAgo;

  const CommentCard({
    super.key,
    required this.comment,
    required this.timeAgo,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: AppSpacing.md),
      child: Padding(
        padding: AppSpacing.paddingLg,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  radius: 16,
                  backgroundColor: Theme.of(context).colorScheme.primaryContainer,
                  child: Icon(
                    Icons.person,
                    size: 18,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
                const SizedBox(width: AppSpacing.sm),
                Text(
                  'Anonymous',
                  style: context.textStyles.titleSmall?.semiBold,
                ),
                const Spacer(),
                Text(
                  timeAgo,
                  style: context.textStyles.bodySmall?.copyWith(
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                  ),
                ),
              ],
            ),
            const SizedBox(height: AppSpacing.md),
            Text(
              comment.content,
              style: context.textStyles.bodyMedium,
            ),
          ],
        ),
      ),
    );
  }
}
