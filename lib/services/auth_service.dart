import 'package:firebase_auth/firebase_auth.dart';
import 'api_helper.dart';

/// App-facing authentication service.
/// Delegates all Firebase API calls to [ApiHelper] so screens stay free of
/// direct API / Firebase logic.
class AuthService {
  final ApiHelper _apiHelper = ApiHelper();

  // Register User
  Future<UserCredential> register(
    String email,
    String password,
  ) async {
    return await _apiHelper.register(email: email, password: password);
  }

  // Login User
  Future<UserCredential> login(
    String email,
    String password,
  ) async {
    return await _apiHelper.login(email: email, password: password);
  }

  // Logout User
  Future<void> logout() async {
    await _apiHelper.logout();
  }

  /// Get the currently signed-in user (or null if none).
  User? get currentUser => _apiHelper.getCurrentUser();

  /// Stream of authentication state changes.
  Stream<User?> get authStateChanges => _apiHelper.authStateChanges;
}
