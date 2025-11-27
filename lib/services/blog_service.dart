import 'package:buddy_ai/models/blog_model.dart';
import 'package:buddy_ai/services/storage_service.dart';
import 'package:flutter/foundation.dart';

class BlogService {
  final StorageService _storage = StorageService();

  Future<void> initialize() async {
    final blogs = await _storage.getBlogs();
    if (blogs.isEmpty) {
      await _initializeSampleBlogs();
    }
  }

  Future<void> _initializeSampleBlogs() async {
    final now = DateTime.now();
    final blogs = [
      BlogModel(
        id: '1',
        title: 'Understanding Anxiety: What It Is and How to Manage It',
        content: '''Anxiety is a natural human emotion that everyone experiences from time to time. It's our body's way of responding to stress or perceived danger, triggering the "fight or flight" response. However, when anxiety becomes chronic or overwhelming, it can significantly impact daily life and well-being.

Common symptoms of anxiety include restlessness, rapid heartbeat, difficulty concentrating, and persistent worry. The good news is that anxiety is highly treatable through various approaches. Cognitive-behavioral therapy (CBT) has proven especially effective, helping individuals identify and change negative thought patterns. Mindfulness practices, regular exercise, adequate sleep, and stress management techniques can also make a significant difference. Remember, seeking professional help is a sign of strength, not weakness, and can provide you with personalized strategies to manage anxiety effectively.''',
        imageUrl: 'assets/images/blog1.jpg',
        authorId: '1',
        createdAt: now.subtract(const Duration(days: 30)),
        updatedAt: now.subtract(const Duration(days: 30)),
      ),
      BlogModel(
        id: '2',
        title: 'The Power of Mindfulness: A Beginner\'s Guide',
        content: '''Mindfulness is the practice of being fully present in the moment, aware of your thoughts and feelings without judgment. This ancient practice has gained widespread recognition in modern mental health care for its remarkable benefits in reducing stress, anxiety, and depression.

Starting a mindfulness practice doesn't require special equipment or extensive training. Begin with just five minutes a day of focused breathing meditation. Sit comfortably, close your eyes, and simply observe your breath moving in and out. When your mind wanders—which it will—gently guide your attention back to your breath without self-criticism. Over time, you can expand your practice to include body scans, mindful walking, or eating. Research shows that regular mindfulness practice can actually change brain structure, strengthening areas associated with emotional regulation and weakening areas linked to stress and anxiety. The key is consistency rather than perfection.''',
        imageUrl: 'assets/images/blog2.webp',
        authorId: '1',
        createdAt: now.subtract(const Duration(days: 25)),
        updatedAt: now.subtract(const Duration(days: 25)),
      ),
      BlogModel(
        id: '3',
        title: 'Breaking the Stigma: Why Mental Health Matters',
        content: '''Mental health is just as important as physical health, yet stigma continues to prevent many people from seeking the help they need. This stigma often stems from misconceptions, fear, and lack of understanding about mental health conditions. Breaking down these barriers is crucial for creating a society where everyone feels comfortable accessing mental health support.

We can all play a role in reducing stigma by educating ourselves about mental health, using respectful language, sharing our own experiences when comfortable, and offering support to those who may be struggling. Mental health conditions are medical conditions—they're not character flaws or signs of weakness. They affect people of all ages, backgrounds, and walks of life. When we normalize conversations about mental health, we create an environment where people feel safe to seek help early, leading to better outcomes. Remember, reaching out for support takes courage, and everyone deserves compassion and understanding on their mental health journey.''',
        imageUrl: 'assets/images/blog3.webp',
        authorId: '1',
        createdAt: now.subtract(const Duration(days: 20)),
        updatedAt: now.subtract(const Duration(days: 20)),
      ),
      BlogModel(
        id: '4',
        title: 'Self-Care Isn\'t Selfish: Essential Practices for Well-Being',
        content: '''Self-care is often misunderstood as indulgence or selfishness, but it's actually a necessary practice for maintaining mental, emotional, and physical health. Taking care of yourself enables you to show up more fully for others and handle life's challenges with greater resilience.

Effective self-care encompasses several dimensions: physical (exercise, nutrition, sleep), emotional (expressing feelings, setting boundaries), mental (engaging in activities you enjoy, continuous learning), social (maintaining meaningful connections), and spiritual (connecting with your values and purpose). Self-care doesn't always mean spa days or expensive retreats—it can be as simple as taking a walk in nature, saying no to commitments that drain you, or spending time with people who lift you up. The key is to make self-care a regular practice, not something you only do when you're already burned out. By prioritizing your well-being, you're investing in your ability to thrive and be there for the people and causes you care about.''',
        imageUrl: 'assets/images/blog4.jpg',
        authorId: '1',
        createdAt: now.subtract(const Duration(days: 15)),
        updatedAt: now.subtract(const Duration(days: 15)),
      ),
      BlogModel(
        id: '5',
        title: 'Building Resilience: Bouncing Back from Life\'s Challenges',
        content: '''Resilience is the ability to adapt and bounce back from adversity, trauma, or significant stress. While some people seem naturally more resilient, the good news is that resilience is a skill that can be developed and strengthened over time through intentional practice.

Key components of resilience include maintaining supportive relationships, practicing self-compassion, developing problem-solving skills, and maintaining a hopeful outlook. It's important to understand that being resilient doesn't mean you won't experience difficulty or distress—rather, it means you have the tools to work through challenges effectively. Building resilience involves accepting that change is part of life, setting realistic goals, taking decisive actions toward those goals, and learning from past experiences. Regular physical activity, adequate sleep, and stress management techniques also contribute to resilience. Remember that building resilience is a personal journey—what works for one person may differ from another. Be patient with yourself as you develop these skills, and don't hesitate to seek professional support when needed.''',
        imageUrl: 'assets/images/blog5.jpg',
        authorId: '1',
        createdAt: now.subtract(const Duration(days: 10)),
        updatedAt: now.subtract(const Duration(days: 10)),
      ),
    ];
    await _storage.saveBlogs(blogs.map((b) => b.toJson()).toList());
  }

  Future<List<BlogModel>> getAllBlogs() async {
    try {
      final blogsJson = await _storage.getBlogs();
      final blogs = blogsJson.map((json) => BlogModel.fromJson(json)).toList();
      blogs.sort((a, b) => b.createdAt.compareTo(a.createdAt));
      return blogs;
    } catch (e) {
      debugPrint('Error getting blogs: $e');
      return [];
    }
  }

  Future<BlogModel?> getBlogById(String id) async {
    try {
      final blogs = await _storage.getBlogs();
      final blogJson = blogs.firstWhere(
        (b) => b['id'] == id,
        orElse: () => <String, dynamic>{},
      );
      if (blogJson.isNotEmpty) {
        return BlogModel.fromJson(blogJson);
      }
    } catch (e) {
      debugPrint('Error getting blog: $e');
    }
    return null;
  }
}
