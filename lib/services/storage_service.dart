import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/foundation.dart';

class StorageService {
  static const String _usersKey = 'users';
  static const String _topicsKey = 'topics';
  static const String _commentsKey = 'comments';
  static const String _blogsKey = 'blogs';
  static const String _currentUserKey = 'currentUser';

  Future<void> saveUsers(List<Map<String, dynamic>> users) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(_usersKey, jsonEncode(users));
    } catch (e) {
      debugPrint('Error saving users: $e');
    }
  }

  Future<List<Map<String, dynamic>>> getUsers() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final usersJson = prefs.getString(_usersKey);
      if (usersJson != null) {
        final decoded = jsonDecode(usersJson) as List;
        return decoded.cast<Map<String, dynamic>>();
      }
    } catch (e) {
      debugPrint('Error loading users: $e');
    }
    return [];
  }

  Future<void> saveTopics(List<Map<String, dynamic>> topics) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(_topicsKey, jsonEncode(topics));
    } catch (e) {
      debugPrint('Error saving topics: $e');
    }
  }

  Future<List<Map<String, dynamic>>> getTopics() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final topicsJson = prefs.getString(_topicsKey);
      if (topicsJson != null) {
        final decoded = jsonDecode(topicsJson) as List;
        return decoded.cast<Map<String, dynamic>>();
      }
    } catch (e) {
      debugPrint('Error loading topics: $e');
    }
    return [];
  }

  Future<void> saveComments(List<Map<String, dynamic>> comments) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(_commentsKey, jsonEncode(comments));
    } catch (e) {
      debugPrint('Error saving comments: $e');
    }
  }

  Future<List<Map<String, dynamic>>> getComments() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final commentsJson = prefs.getString(_commentsKey);
      if (commentsJson != null) {
        final decoded = jsonDecode(commentsJson) as List;
        return decoded.cast<Map<String, dynamic>>();
      }
    } catch (e) {
      debugPrint('Error loading comments: $e');
    }
    return [];
  }

  Future<void> saveBlogs(List<Map<String, dynamic>> blogs) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(_blogsKey, jsonEncode(blogs));
    } catch (e) {
      debugPrint('Error saving blogs: $e');
    }
  }

  Future<List<Map<String, dynamic>>> getBlogs() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final blogsJson = prefs.getString(_blogsKey);
      if (blogsJson != null) {
        final decoded = jsonDecode(blogsJson) as List;
        return decoded.cast<Map<String, dynamic>>();
      }
    } catch (e) {
      debugPrint('Error loading blogs: $e');
    }
    return [];
  }

  Future<void> saveCurrentUser(String? userId) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      if (userId != null) {
        await prefs.setString(_currentUserKey, userId);
      } else {
        await prefs.remove(_currentUserKey);
      }
    } catch (e) {
      debugPrint('Error saving current user: $e');
    }
  }

  Future<String?> getCurrentUser() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      return prefs.getString(_currentUserKey);
    } catch (e) {
      debugPrint('Error getting current user: $e');
      return null;
    }
  }
}
