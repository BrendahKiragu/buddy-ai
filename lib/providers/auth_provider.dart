import 'package:flutter/foundation.dart';
import 'package:buddy_ai/models/user_model.dart';
import 'package:buddy_ai/services/auth_service.dart';

class AuthProvider extends ChangeNotifier {
  final AuthService _authService = AuthService();
  bool _isInitialized = false;

  bool get isInitialized => _isInitialized;
  UserModel? get currentUser => _authService.currentUser;
  bool get isLoggedIn => _authService.isLoggedIn;

  Future<void> initialize() async {
    await _authService.initialize();
    _isInitialized = true;
    notifyListeners();
  }

  Future<bool> login(String email, String password) async {
    final success = await _authService.login(email, password);
    if (success) {
      notifyListeners();
    }
    return success;
  }

  Future<bool> signUp(String email, String password, String displayName) async {
    final success = await _authService.signUp(email, password, displayName);
    if (success) {
      notifyListeners();
    }
    return success;
  }

  Future<void> logout() async {
    await _authService.logout();
    notifyListeners();
  }
}
