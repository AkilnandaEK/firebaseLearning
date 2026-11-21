import 'package:firebase_auth/firebase_auth.dart';

/// Centralized API helper for all Firebase / backend integrations.
///
/// All API calls (login, register, logout, etc.) live here so the screens
/// only handle UI and navigation.
class ApiHelper {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Singleton so the same instance is used across the app
  static final ApiHelper _instance = ApiHelper._internal();
  factory ApiHelper() => _instance;
  ApiHelper._internal();

  /// Sign in with email and password.
  /// Returns [UserCredential] on success, throws a [String] error message on failure.
  Future<UserCredential> login({
    required String email,
    required String password,
  }) async {
    try {
      return await _auth.signInWithEmailAndPassword(
        email: email.trim(),
        password: password,
      );
    } on FirebaseAuthException catch (e) {
      throw _mapAuthError(e.code);
    } catch (_) {
      throw 'An unexpected error occurred. Please try again.';
    }
  }

  /// Register a new user with email and password.
  /// Returns [UserCredential] on success, throws a [String] error message on failure.
  Future<UserCredential> register({
    required String email,
    required String password,
  }) async {
    try {
      return await _auth.createUserWithEmailAndPassword(
        email: email.trim(),
        password: password,
      );
    } on FirebaseAuthException catch (e) {
      throw _mapAuthError(e.code);
    } catch (_) {
      throw 'An unexpected error occurred. Please try again.';
    }
  }

  /// Sign out the current user.
  Future<void> logout() async {
    try {
      await _auth.signOut();
    } on FirebaseAuthException catch (e) {
      throw _mapAuthError(e.code);
    } catch (_) {
      throw 'An unexpected error occurred while signing out.';
    }
  }

  /// Get the currently signed-in user (or null if none).
  User? getCurrentUser() => _auth.currentUser;

  /// Stream of authentication state changes.
  Stream<User?> get authStateChanges => _auth.authStateChanges();

  /// Map Firebase Auth error codes to user-friendly messages.
  String _mapAuthError(String code) {
    switch (code) {
      case 'user-not-found':
        return 'No user found for this email.';
      case 'wrong-password':
        return 'Wrong password provided.';
      case 'email-already-in-use':
        return 'An account already exists for this email.';
      case 'weak-password':
        return 'The password provided is too weak.';
      case 'invalid-email':
        return 'The email address is not valid.';
      case 'user-disabled':
        return 'This user account has been disabled.';
      case 'too-many-requests':
        return 'Too many failed attempts. Please try again later.';
      case 'operation-not-allowed':
        return 'This sign-in method is not allowed.';
      default:
        return 'Authentication failed. Please try again.';
    }
  }
}
