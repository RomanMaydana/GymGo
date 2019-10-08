import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

class User {
  final String uid;

  User({this.uid});
}

class FirebaseAuthService{
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  User _userFromFirebase(FirebaseUser user) {
    return user == null ? null : User(uid: user.uid);
  }
  Stream<User> get onAuthStateChanged {
    return _firebaseAuth.onAuthStateChanged.map(_userFromFirebase);
  }
  Future<void> signOut(){
    return _firebaseAuth.signOut();
  }
}
