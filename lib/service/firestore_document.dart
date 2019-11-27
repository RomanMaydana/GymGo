import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:gym_go/model/suscripcion.dart';

class FirestoreDocument {
  Stream<QuerySnapshot> getSubscriptionForGymId(String gymId) {
    return Firestore.instance
        .collection('Subscription')
        .where('gymId', isEqualTo: gymId)
        .snapshots();
  }

  Stream<QuerySnapshot> getChechInUserId(String userId) {
    return Firestore.instance
        .collection('CheckIn')
        .where('userId', isEqualTo: userId)
        .orderBy('creationDate', descending: true)
        .snapshots();
  }

  Stream<QuerySnapshot> getChechInByGymId(String gymId) {
    return Firestore.instance
        .collection('CheckIn')
        .where('gymId', isEqualTo: gymId)
        .snapshots();
  }
}
