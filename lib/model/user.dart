import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'dart:async';

import 'package:geolocator/geolocator.dart';
import 'package:latlong/latlong.dart';

enum AuthStatus { sign_in, sign_up, logged_in }

class User {
  final String fullName;
  final String userId;
  final String ci;
  final DateTime birthDate;
  final String picture;
  final String email;
  final String celular;
  final String type;
  final String sexo;
  User(
      {this.fullName,
      this.userId,
      this.ci,
      this.birthDate,
      this.picture,
      this.email,
      this.celular,
      this.sexo,
      this.type = 'client'});

  factory User.fromMap(Map doc) {
    User user = User(
        fullName: doc['fullName'],
        userId: doc['userId'],
        ci: doc['ci'],
        birthDate: doc['birthDate'],
        picture: doc['picture'],
        email: doc['email'],
        celular: doc['celular'],
        sexo: doc['sexo'],
        type: doc['type']);
    return user;
  }
  Map<String, dynamic> toMap() {
    return {
      'fullName': this.fullName,
      'email': this.email,
      'userId': this.userId,
      'ci': this.ci,
      'birthDate': this.birthDate,
      'picture': this.picture,
      'celular': this.celular,
      'sexo': this.sexo,
      'type': this.type
    };
  }

  get birthDateExact =>
      '${this.birthDate.year}/${this.birthDate.month}/${this.birthDate.day}';
}

class UserModel extends ChangeNotifier {
  FirebaseUser userFirebase;
  StreamSubscription userAuthSub;
  AuthStatus _authStatus;
  Position _position;
  User _user;
  UserModel() {
    _authStatus = AuthStatus.sign_in;
    getPosition();
    userAuthSub = FirebaseAuth.instance.onAuthStateChanged
        .listen(_getUserFirebase, onError: (e) {
      print('AuthProvider - FirebaseAuth - onAuthStateChanged - $e');
    });
  }
  Future getPosition() async {
    _position = await Geolocator()
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
  }

  getCurrentLocation() {
    return LatLng(_position.latitude, _position.longitude);
  }

  Future<void> _getUserFirebase(FirebaseUser newUser) async {
    if (newUser != null) {
      var docUser = await Firestore.instance
          .collection('user')
          .document(newUser.uid.toString())
          .get();
      this._user = User.fromMap(docUser.data);
      print(this._user.fullName);
      _authStatus = AuthStatus.logged_in;
      userFirebase = newUser;
      notifyListeners();
    }
  }

  @override
  void dispose() {
    if (userAuthSub != null) {
      userAuthSub.cancel();
      userAuthSub = null;
    }
    super.dispose();
  }

  AuthStatus get statusAuth {
    return _authStatus;
  }

  void signIn(String email, String password) {
    print('entro');
    FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password)
        .then((e) {
      print(e);
    }).catchError((e) {
      print('error $e');
    }).whenComplete(() {
      print('algo salio mal ');
    });
  }

  Future<void> signUp(String email, String password, String name) async {
    try {
      FirebaseUser userF = (await FirebaseAuth.instance
              .createUserWithEmailAndPassword(email: email, password: password))
          .user;
      Firestore firestore = Firestore.instance;
      User newUser =
          User(email: email, fullName: name, userId: userF.uid.toString());

      await firestore
          .collection('user')
          .document(userF.uid.toString())
          .setData(newUser.toMap());
    } catch (e) {
      print('error $e');
    }
    // if (result != null) {
    //   _authStatus = AuthStatus.logged_in;
    //   notifyListeners();
    // }
  }

  Future<bool> _checkUserExist(String userID) async {
    bool exists = false;
    try {
      await Firestore.instance.document("users/$userID").get().then((doc) {
        if (doc.exists)
          exists = true;
        else
          exists = false;
      });
      return exists;
    } catch (e) {
      return false;
    }
  }

  User getUser() {
    return this._user;
  }

  void signOut() {
    _authStatus = AuthStatus.sign_in;
    FirebaseAuth.instance.signOut();
    notifyListeners();
  }

  void changedAuthSignUp() {
    _authStatus = AuthStatus.sign_up;
    notifyListeners();
  }

  void changedAuthSignIn() {
    _authStatus = AuthStatus.sign_in;
    notifyListeners();
  }

  void changedAuthLoggedIn() {
    _authStatus = AuthStatus.logged_in;
    notifyListeners();
  }
}
