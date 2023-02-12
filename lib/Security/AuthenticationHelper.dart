import 'package:firebase_auth/firebase_auth.dart';

class AuthenticationHelper {
  final _auth = FirebaseAuth.instance;

  FirebaseAuth get instance => _auth;

  User? get currentUser => _auth.currentUser;

  Stream<User?> get authStateChanges => _auth.authStateChanges();
}
