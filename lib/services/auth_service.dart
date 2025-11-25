import 'package:buddy_ai/models/user_model.dart';
import 'package:buddy_ai/services/storage_service.dart';
import 'package:flutter/foundation.dart';

class AuthService {
  final StorageService _storage = StorageService();
  UserModel? _currentUser;

  Future<void> initialize() async {
    final users = await _storage.getUsers();
    if (users.isEmpty) {
      await _initializeSampleUsers();
    }
    final currentUserId = await _storage.getCurrentUser();
    if (currentUserId != null) {
      final allUsers = await _storage.getUsers();
      final userJson = allUsers.firstWhere(
        (u) => u['id'] == currentUserId,
        orElse: () => <String, dynamic>{},
      );
      if (userJson.isNotEmpty) {
        _currentUser = UserModel.fromJson(userJson);
      }
    }
  }

  Future<void> _initializeSampleUsers() async {
    final now = DateTime.now();
    final users = [
      UserModel(
        id: '1',
        email: 'alex.miller@email.com',
        password: 'password123',
        displayName: 'Alex Miller',
        createdAt: now.subtract(const Duration(days: 90)),
        updatedAt: now,
      ),
      UserModel(
        id: '2',
        email: 'sarah.jones@email.com',
        password: 'password123',
        displayName: 'Sarah Jones',
        createdAt: now.subtract(const Duration(days: 75)),
        updatedAt: now,
      ),
      UserModel(
        id: '3',
        email: 'michael.chen@email.com',
        password: 'password123',
        displayName: 'Michael Chen',
        createdAt: now.subtract(const Duration(days: 60)),
        updatedAt: now,
      ),
      UserModel(
        id: '4',
        email: 'emma.wilson@email.com',
        password: 'password123',
        displayName: 'Emma Wilson',
        createdAt: now.subtract(const Duration(days: 45)),
        updatedAt: now,
      ),
      UserModel(
        id: '5',
        email: 'david.brown@email.com',
        password: 'password123',
        displayName: 'David Brown',
        createdAt: now.subtract(const Duration(days: 30)),
        updatedAt: now,
      ),
    ];
    await _storage.saveUsers(users.map((u) => u.toJson()).toList());
  }

  UserModel? get currentUser => _currentUser;

  bool get isLoggedIn => _currentUser != null;

  Future<bool> login(String email, String password) async {
    try {
      final users = await _storage.getUsers();
      final userJson = users.firstWhere(
        (u) => u['email'] == email && u['password'] == password,
        orElse: () => <String, dynamic>{},
      );
      if (userJson.isNotEmpty) {
        _currentUser = UserModel.fromJson(userJson);
        await _storage.saveCurrentUser(_currentUser!.id);
        return true;
      }
      return false;
    } catch (e) {
      debugPrint('Login error: $e');
      return false;
    }
  }

  Future<bool> signUp(String email, String password, String displayName) async {
    try {
      final users = await _storage.getUsers();
      if (users.any((u) => u['email'] == email)) {
        return false;
      }
      final now = DateTime.now();
      final newUser = UserModel(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        email: email,
        password: password,
        displayName: displayName,
        createdAt: now,
        updatedAt: now,
      );
      users.add(newUser.toJson());
      await _storage.saveUsers(users);
      _currentUser = newUser;
      await _storage.saveCurrentUser(_currentUser!.id);
      return true;
    } catch (e) {
      debugPrint('Sign up error: $e');
      return false;
    }
  }

  Future<void> logout() async {
    _currentUser = null;
    await _storage.saveCurrentUser(null);
  }

  Future<UserModel?> getUserById(String userId) async {
    try {
      final users = await _storage.getUsers();
      final userJson = users.firstWhere(
        (u) => u['id'] == userId,
        orElse: () => <String, dynamic>{},
      );
      if (userJson.isNotEmpty) {
        return UserModel.fromJson(userJson);
      }
    } catch (e) {
      debugPrint('Get user error: $e');
    }
    return null;
  }
}
