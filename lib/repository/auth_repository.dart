import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AuthRepository {
  const AuthRepository(this._auth);
  final FirebaseAuth _auth;

  Stream<User?> get authStateChange => _auth.idTokenChanges();
  Future<User?> signInWithEmailAndPassword(
      String email, String password) async {
    try {
      final result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      return result.user;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        throw AuthException("User Not Found");
      } else if (e.code == 'wrong-password') {
        throw AuthException("Wrong Password");
      } else {
        throw AuthException("An error occured. Please try again");
      }
    }
  }

  Future<User?> signUpWithEmailAndPassword(
      String email, String password) async {
    try {
      final result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      return result.user;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        throw AuthException("User Not Found");
      } else if (e.code == 'wrong-password') {
        throw AuthException("Wrong Password");
      } else {
        throw AuthException("An error occured. Please try again");
      }
    }
  }

  Future<void> signOut() async {
    await _auth.signOut();
  }
}

class AuthException implements Exception {
  final String message;

  AuthException(this.message);

  @override
  String toString() {
    return message;
  }
}
