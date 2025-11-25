import 'package:buddy_ai/models/comment_model.dart';
import 'package:buddy_ai/models/topic_model.dart';
import 'package:buddy_ai/services/storage_service.dart';
import 'package:flutter/foundation.dart';

class TopicService {
  final StorageService _storage = StorageService();

  Future<void> initialize() async {
    final topics = await _storage.getTopics();
    if (topics.isEmpty) {
      await _initializeSampleData();
    }
  }

  Future<void> _initializeSampleData() async {
    final now = DateTime.now();
    final topics = [
      TopicModel(
        id: '1',
        title: 'Dealing with anxiety in social situations',
        commentCount: 4,
        createdAt: now.subtract(const Duration(days: 10)),
        updatedAt: now.subtract(const Duration(days: 1)),
      ),
      TopicModel(
        id: '2',
        title: 'Coping strategies for work-related stress',
        commentCount: 4,
        createdAt: now.subtract(const Duration(days: 8)),
        updatedAt: now.subtract(const Duration(days: 2)),
      ),
      TopicModel(
        id: '3',
        title: 'Finding motivation during difficult times',
        commentCount: 4,
        createdAt: now.subtract(const Duration(days: 6)),
        updatedAt: now.subtract(const Duration(hours: 12)),
      ),
      TopicModel(
        id: '4',
        title: 'Building healthy sleep habits',
        commentCount: 4,
        createdAt: now.subtract(const Duration(days: 4)),
        updatedAt: now.subtract(const Duration(hours: 5)),
      ),
      TopicModel(
        id: '5',
        title: 'Managing overwhelming emotions',
        commentCount: 4,
        createdAt: now.subtract(const Duration(days: 2)),
        updatedAt: now.subtract(const Duration(hours: 3)),
      ),
    ];

    final comments = [
      CommentModel(id: '1', topicId: '1', userId: '1', content: 'I find that deep breathing exercises really help me before entering social situations. Taking a few minutes to center myself makes a huge difference.', isAnonymous: true, createdAt: now.subtract(const Duration(days: 9)), updatedAt: now.subtract(const Duration(days: 9))),
      CommentModel(id: '2', topicId: '1', userId: '2', content: 'Starting with small gatherings has been my approach. I gradually increased the size of events I attend, and my confidence grew over time.', isAnonymous: true, createdAt: now.subtract(const Duration(days: 8)), updatedAt: now.subtract(const Duration(days: 8))),
      CommentModel(id: '3', topicId: '1', userId: '3', content: 'Having a trusted friend nearby helps me feel more secure. Sometimes just knowing someone understands makes all the difference.', isAnonymous: true, createdAt: now.subtract(const Duration(days: 7)), updatedAt: now.subtract(const Duration(days: 7))),
      CommentModel(id: '4', topicId: '1', userId: '4', content: 'I practice positive self-talk before social events. Reminding myself that most people are focused on themselves, not judging me, helps reduce anxiety.', isAnonymous: true, createdAt: now.subtract(const Duration(days: 1)), updatedAt: now.subtract(const Duration(days: 1))),
      
      CommentModel(id: '5', topicId: '2', userId: '2', content: 'Setting clear boundaries between work and personal time has been crucial. I turn off work notifications after hours and it has really helped.', isAnonymous: true, createdAt: now.subtract(const Duration(days: 7)), updatedAt: now.subtract(const Duration(days: 7))),
      CommentModel(id: '6', topicId: '2', userId: '3', content: 'Taking regular breaks during the workday, even just 5 minutes to walk around, helps me reset and manage stress better.', isAnonymous: true, createdAt: now.subtract(const Duration(days: 6)), updatedAt: now.subtract(const Duration(days: 6))),
      CommentModel(id: '7', topicId: '2', userId: '4', content: 'I started using a priority matrix to organize tasks. It helps me focus on what truly matters and reduces the feeling of being overwhelmed.', isAnonymous: true, createdAt: now.subtract(const Duration(days: 5)), updatedAt: now.subtract(const Duration(days: 5))),
      CommentModel(id: '8', topicId: '2', userId: '5', content: 'Talking to my manager about workload helped more than I expected. Sometimes we need to advocate for ourselves at work.', isAnonymous: true, createdAt: now.subtract(const Duration(days: 2)), updatedAt: now.subtract(const Duration(days: 2))),
      
      CommentModel(id: '9', topicId: '3', userId: '1', content: 'Breaking big goals into tiny, achievable steps helps me. Even accomplishing something small gives me momentum to keep going.', isAnonymous: true, createdAt: now.subtract(const Duration(days: 5)), updatedAt: now.subtract(const Duration(days: 5))),
      CommentModel(id: '10', topicId: '3', userId: '3', content: 'I keep a gratitude journal. Writing down three good things each day helps me maintain perspective during tough times.', isAnonymous: true, createdAt: now.subtract(const Duration(days: 4)), updatedAt: now.subtract(const Duration(days: 4))),
      CommentModel(id: '11', topicId: '3', userId: '4', content: 'Physical exercise, even just a short walk, boosts my mood and motivation. The mind-body connection is real.', isAnonymous: true, createdAt: now.subtract(const Duration(days: 3)), updatedAt: now.subtract(const Duration(days: 3))),
      CommentModel(id: '12', topicId: '3', userId: '5', content: 'Connecting with supportive people helps me stay motivated. Sometimes we need to lean on others when our own motivation is low.', isAnonymous: true, createdAt: now.subtract(const Duration(hours: 12)), updatedAt: now.subtract(const Duration(hours: 12))),
      
      CommentModel(id: '13', topicId: '4', userId: '1', content: 'Creating a consistent bedtime routine has transformed my sleep. I dim lights an hour before bed and avoid screens.', isAnonymous: true, createdAt: now.subtract(const Duration(days: 3)), updatedAt: now.subtract(const Duration(days: 3))),
      CommentModel(id: '14', topicId: '4', userId: '2', content: 'I stopped consuming caffeine after 2 PM and my sleep quality improved dramatically. It took a few days to adjust but was worth it.', isAnonymous: true, createdAt: now.subtract(const Duration(days: 2)), updatedAt: now.subtract(const Duration(days: 2))),
      CommentModel(id: '15', topicId: '4', userId: '3', content: 'Using a white noise machine helps me fall asleep faster and stay asleep through the night. Highly recommend trying it.', isAnonymous: true, createdAt: now.subtract(const Duration(days: 1)), updatedAt: now.subtract(const Duration(days: 1))),
      CommentModel(id: '16', topicId: '4', userId: '5', content: 'Keeping my bedroom cool and dark has made a huge difference. Also, I only use my bed for sleep, not work or watching TV.', isAnonymous: true, createdAt: now.subtract(const Duration(hours: 5)), updatedAt: now.subtract(const Duration(hours: 5))),
      
      CommentModel(id: '17', topicId: '5', userId: '2', content: 'I learned to name my emotions instead of just feeling overwhelmed. Simply identifying "I feel anxious" or "I feel sad" helps me process them better.', isAnonymous: true, createdAt: now.subtract(const Duration(days: 1, hours: 18)), updatedAt: now.subtract(const Duration(days: 1, hours: 18))),
      CommentModel(id: '18', topicId: '5', userId: '3', content: 'Journaling helps me release overwhelming emotions. Getting thoughts out of my head and onto paper provides relief and clarity.', isAnonymous: true, createdAt: now.subtract(const Duration(days: 1, hours: 12)), updatedAt: now.subtract(const Duration(days: 1, hours: 12))),
      CommentModel(id: '19', topicId: '5', userId: '4', content: 'I practice the 5-4-3-2-1 grounding technique when emotions feel too big. It helps me stay present and calm down.', isAnonymous: true, createdAt: now.subtract(const Duration(hours: 8)), updatedAt: now.subtract(const Duration(hours: 8))),
      CommentModel(id: '20', topicId: '5', userId: '1', content: 'Reaching out to trusted friends when emotions are overwhelming has been invaluable. We don\'t have to face difficult feelings alone.', isAnonymous: true, createdAt: now.subtract(const Duration(hours: 3)), updatedAt: now.subtract(const Duration(hours: 3))),
    ];

    await _storage.saveTopics(topics.map((t) => t.toJson()).toList());
    await _storage.saveComments(comments.map((c) => c.toJson()).toList());
  }

  Future<List<TopicModel>> getAllTopics() async {
    try {
      final topicsJson = await _storage.getTopics();
      return topicsJson.map((json) => TopicModel.fromJson(json)).toList();
    } catch (e) {
      debugPrint('Error getting topics: $e');
      return [];
    }
  }

  Future<TopicModel?> getTopicById(String id) async {
    try {
      final topics = await _storage.getTopics();
      final topicJson = topics.firstWhere(
        (t) => t['id'] == id,
        orElse: () => <String, dynamic>{},
      );
      if (topicJson.isNotEmpty) {
        return TopicModel.fromJson(topicJson);
      }
    } catch (e) {
      debugPrint('Error getting topic: $e');
    }
    return null;
  }

  Future<List<CommentModel>> getCommentsByTopicId(String topicId) async {
    try {
      final commentsJson = await _storage.getComments();
      return commentsJson
          .where((c) => c['topicId'] == topicId)
          .map((json) => CommentModel.fromJson(json))
          .toList();
    } catch (e) {
      debugPrint('Error getting comments: $e');
      return [];
    }
  }

  Future<void> addComment(CommentModel comment) async {
    try {
      final comments = await _storage.getComments();
      comments.add(comment.toJson());
      await _storage.saveComments(comments);

      final topics = await _storage.getTopics();
      final topicIndex = topics.indexWhere((t) => t['id'] == comment.topicId);
      if (topicIndex != -1) {
        final topic = TopicModel.fromJson(topics[topicIndex]);
        topics[topicIndex] = topic.copyWith(
          commentCount: topic.commentCount + 1,
          updatedAt: DateTime.now(),
        ).toJson();
        await _storage.saveTopics(topics);
      }
    } catch (e) {
      debugPrint('Error adding comment: $e');
    }
  }
}
