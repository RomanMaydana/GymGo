import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/widgets.dart';
import 'package:gym_go/model/gym.dart';

class GymModel extends ChangeNotifier {
  List<Gym> myListGyms;
  List<Gym> availableGyms;
  GymModel() {
    this.myListGyms = [];
    this.availableGyms = [];
    this.getGym();
    // this.getGymSnapshot();
  }

  Future<void> getCollectionMyGym({String userId}) async {
    // falta
    try {
      List<Gym> list = [];
      QuerySnapshot snapshot = await Firestore.instance
          .collection('Gym')
          .where('userId', isEqualTo: userId)
          .getDocuments();

      snapshot.documentChanges.forEach((DocumentChange doc) {
        Gym gym = Gym.fromMap(doc.document.data);
        list.add(gym);
      });
      this.myListGyms = list;
      notifyListeners();
    } catch (e) {
      print('error $e');
    }
  }

  addMyGym(Gym gym) {
    myListGyms.add(gym);
    availableGyms.add(gym);
    notifyListeners();
  }

  Future<void> getGym() async {
    try {
      List<Gym> list = [];
      QuerySnapshot snapshot = await Firestore.instance
          .collection('Gym')
          .where('state', isEqualTo: true)
          .where('stateVerify', isEqualTo: true)
          .getDocuments();

      snapshot.documentChanges.forEach((DocumentChange doc) {
        Gym gym = Gym.fromMap(doc.document.data);
        
        list.add(gym);
      });
      
      this.availableGyms = list;
      notifyListeners();
    } catch (e) {
      print('error $e');
    }
  }

  getGymSnapshot() async {
    Firestore.instance.collection('Gym').snapshots().listen((snapshot) {
      snapshot.documentChanges.forEach((DocumentChange doc) {
        Gym gym = Gym.fromMap(doc.document.data);
        

        this.availableGyms.add(gym);
        notifyListeners();
      });
    });
  }

  removePro() {
    this.availableGyms.removeLast();
    notifyListeners();
  }
}
