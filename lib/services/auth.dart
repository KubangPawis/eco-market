import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Sign in with email and password
  Future<User?> signIn(String email, String password) async {
    try {
      final result = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return result.user;
    } catch (e) {
      print('Sign in error: $e');
      rethrow;
    }
  }

  // Sign up with email and password
  Future<User?> signUp(String email, String password) async {
    try {
      final result = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      return result.user;
    } catch (e) {
      print('Sign up error: $e');
      rethrow;
    }
  }

  // Sign out
  Future<void> signOut() async {
    await _auth.signOut();
  }

  // Get current user
  User? get currentUser => _auth.currentUser;

  // Listen for authentication state changes
  Stream<User?> get authStateChanges => _auth.authStateChanges();
}
