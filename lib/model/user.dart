import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'dart:async';

import 'package:geolocator/geolocator.dart';
import 'package:latlong/latlong.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

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
  final String token;
  User(
      {this.token,
      this.fullName,
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
        type: doc['type'],
        token: doc['token']);
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
      'type': this.type,
      'token': this.token
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
  TabController _tabController;
  FirebaseMessaging _firebaseMessaging;
  UserModel() {
    _authStatus = AuthStatus.sign_in;
    _firebaseMessaging = FirebaseMessaging();

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

  registrationTacontroller({TabController controller}) {
    this._tabController = controller;

    // this._tabController.addListener((){

    //   toIndexInTabView(this._tabController.index);

    // });
  }

  toIndexInTabView(int index) {
    this._tabController.animateTo(index,
        duration: Duration(milliseconds: 700), curve: Curves.ease);
    notifyListeners();
  }

  getTabController() {
    return _tabController;
  }

  getCurrentLocation() {
    return LatLng(_position.latitude, _position.longitude);
  }

  Future<void> _getUserFirebase(FirebaseUser newUser) async {
    if (newUser != null) {
      try {
        var docUser = await Firestore.instance
            .collection('user')
            .document(newUser.uid.toString())
            .get();
        this._user = User.fromMap(docUser.data);

        _authStatus = AuthStatus.logged_in;
        userFirebase = newUser;
        notifyListeners();
      } catch (e) {
        print('error $e');
      }
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

  Future<String> getToken() async {
    String token = await _firebaseMessaging.getToken();
    print('======== TOKEN =========');
    print(token);
    // e2p6qS7Qvng:APA91bEDPqBoPBjaXPpN7JPLRvnZdEb0RTGBjFww7wWUQonLwi9h1sN2lB9RddFgzWTbb9IlYEpH4ZuvyCJNkR1D6FNGy8sQ8q7_dej9UechZiZKThN8UYreVs8w08ANLso7gekDubpF
    return token;
  }

  Future<void> signIn(String email, String password) async {
    try {
      final data = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      final token = await getToken();
      print(data.user.uid);

      await Firestore.instance
          .collection('user')
          .document(data.user.uid)
          .updateData({'token': token});
      
    } catch (e) {
      print('error $e');
    }
  }

  Future<void> signUp(String email, String password, String name) async {
    try {
      FirebaseUser userF = (await FirebaseAuth.instance
              .createUserWithEmailAndPassword(email: email, password: password))
          .user;
      final token = await getToken();
      Firestore firestore = Firestore.instance;
      User newUser = User(
          email: email,
          fullName: name,
          userId: userF.uid.toString(),
          token: token);

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
