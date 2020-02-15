import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:timebuddy/models/user.dart';

class AuthService with ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  //auth change user stream
  Stream<User> get user {
    return _auth.onAuthStateChanged.map(_firebaseUserToUser);
  }

  //sign in anonymously
  Future<User> signInAnonymously() async {
    try {
      final AuthResult result = await _auth.signInAnonymously();
      return _firebaseUserToUser(result.user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future<User> signInWithEmailAndPassword(String email, String password) async {
    try {
      final result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      FirebaseUser user = result.user;
      return _firebaseUserToUser(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  //sign out
  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future<bool> forgotPassword(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
      return true;
    } catch (e) {
      print(e.toString());
      return false;
    }
  }

  //helper methods
  User _firebaseUserToUser(FirebaseUser fbUser) {
    return fbUser != null ? User(uid: fbUser.uid, email: fbUser.email) : null;
  }
}
