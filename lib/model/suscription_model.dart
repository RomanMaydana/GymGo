import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/widgets.dart';
import 'package:gym_go/model/check_in.dart';
import 'package:gym_go/model/gym.dart';
import 'package:gym_go/model/suscripcion.dart';
import 'package:gym_go/model/user.dart';

class SubscriptionModel extends ChangeNotifier {
  Subscripcion _subscription;
  List<Subscripcion> availableSubs;
  bool _stateGetSubs = false;
  SubscriptionModel() {
    this._subscription = Subscripcion();
    availableSubs = [];
  }
  Subscripcion get subscripcion {
    return this._subscription;
  }

  Subscripcion verifySubscriptionInGym(String gymId, String plan) {
    print('$plan');
    Subscripcion subscripcion = null;

    for (Subscripcion subs in this.availableSubs) {
      print('subs ${subs.plan}');
      if (subs.gymId == gymId) {
        subscripcion = subs;
      }
    }
    if (subscripcion != null) return subscripcion;

    for (Subscripcion subs in this.availableSubs) {
      if (subs.plan == plan) {
        subscripcion = subs;
        break;
      }
    }

    return subscripcion;
  }

  void initSubscription(DateTime dateTime) {
    this._subscription.initSubscription = dateTime;
    notifyListeners();
  }

  void finalSubscription(DateTime dateTime) {
    this._subscription.finalSubscription = dateTime;
    notifyListeners();
  }

  Future<Subscripcion> addSubscription() async {
    try {
      Firestore firestore = Firestore.instance;
      DocumentReference resultAdd =
          await firestore.collection('Subscription').add(_subscription.toMap());
      _subscription.idSubscription = resultAdd.documentID;
      await resultAdd.updateData({'idSubscription': resultAdd.documentID});
      this.availableSubs.add(_subscription);
      notifyListeners();
      return _subscription;
    } catch (e) {
      print('error $e');
    }
  }

  Future<void> getSubscription(String userId) async {
    try {
      List<Subscripcion> list = [];
      QuerySnapshot snapshot = await Firestore.instance
          .collection('Subscription')
          .where('idUser', isEqualTo: userId)
          
          .getDocuments();

      snapshot.documentChanges.forEach((DocumentChange doc) {
        Subscripcion subs = Subscripcion.fromMap(doc.document.data);
        print('plan ' + subs.plan);
        list.add(subs);
      });

      this.availableSubs = list;
      notifyListeners();
    } catch (e) {
      print('error $e');
    }
  }

  Future registredCheckIn(Subscripcion subscripcion, Gym gym, User user)async {
    CheckIn checkIn = CheckIn(
      userId: user.userId,
      gymId: gym.gymId,
      idSubscription: subscripcion.idSubscription,
      nameGym: gym.name,
      nameUser: user.fullName,
    );
    Firestore firestore = Firestore.instance;
    await firestore.collection('CheckIn').add(checkIn.toMap());
  }

  void getSubscriptionWhenVerify(String userId) {
    if (!this._stateGetSubs) {
      this.getSubscription(userId);
      this._stateGetSubs = true;
    }
  }

  // getSubsSnapshot(String userId) async {
  //   Firestore.instance
  //       .collection('Subscription')
  //       .where('idUser',isEqualTo: userId)
  //       .snapshots()
  //       .listen((snapshot) {
  //     snapshot.documentChanges.forEach((DocumentChange doc) {
  //       Subscripcion subs = Subscripcion.fromMap(doc.document.data);
  //       print('existe subs');
  //       this.availableSubs.add(subs);
  //       notifyListeners();
  //     });
  //   });
  // }
}
