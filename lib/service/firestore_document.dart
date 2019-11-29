import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:gym_go/model/suscripcion.dart';

class FirestoreDocument {
  Stream<DocumentSnapshot> getCheckInDocument(String id) {
    return Firestore.instance.collection('CheckIn').document(id).snapshots();
  }
  Stream<DocumentSnapshot> getSubscriptionDocument(String id) {
    return Firestore.instance.collection('Subscription').document(id).snapshots();
  }
  Stream<QuerySnapshot> getSubscriptionForGymId(String gymId) {
    return Firestore.instance
        .collection('Subscription')
        .where('gymId', isEqualTo: gymId)
        .snapshots();
  }

  Stream<QuerySnapshot> getGymyByPlan(String plan) {
    return Firestore.instance
        .collection('Gym')
        .where('plan', isEqualTo: plan)
        .where('statePlan',isEqualTo: true)
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

  Stream<QuerySnapshot> getChechInByGymIdAndSuscription(
      String gymId, String userId) {
    return Firestore.instance
        .collection('CheckIn')
        .where('gymId', isEqualTo: gymId)
        .where('userId', isEqualTo: userId)
        .snapshots();
  }
}
