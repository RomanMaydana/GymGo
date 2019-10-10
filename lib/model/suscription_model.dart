import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/widgets.dart';
import 'package:gym_go/model/suscripcion.dart';

class SubscriptionModel extends ChangeNotifier {
  Subscripcion _subscription;
  List<Subscripcion> availableSubs;
  SubscriptionModel() {
    this._subscription = Subscripcion();
    availableSubs = [];
  }
  Subscripcion get subscripcion {
    return this._subscription;
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
      this.availableSubs = [];
      this.availableSubs.add(_subscription);
      notifyListeners();
      return _subscription;
    } catch (e) {
      print('error $e');
    }
  }

  Future<void> getGym(String userId) async {
    try {
      List<Subscripcion> list = [];
      QuerySnapshot snapshot =
          await Firestore.instance.collection('Subscription').getDocuments();

      snapshot.documentChanges.forEach((DocumentChange doc) {
        Subscripcion subs = Subscripcion.fromMap(doc.document.data);
        list.add(subs);
      });
      this.availableSubs = list;
      notifyListeners();
    } catch (e) {
      print('error $e');
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
