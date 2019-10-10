import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/widgets.dart';
import 'package:gym_go/model/suscripcion.dart';

class SubscriptionModel extends ChangeNotifier {
  Subscripcion _subscription;

  SubscriptionModel() {
    this._subscription = Subscripcion();
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
      resultAdd.updateData({'idSubscription': resultAdd.documentID});
      return _subscription;
    } catch (e) {
      print('error $e');
    }
  }
}
