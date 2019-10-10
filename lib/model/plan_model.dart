import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/widgets.dart';
import 'package:gym_go/model/plan.dart';

class PlanModel extends ChangeNotifier {
  List<Plan> _listPlan;

  PlanModel() {
    _listPlan = [];
    this.getPlan();
  }
  get listPlan {
    return _listPlan;
  }

  Future<void> getPlan() async {
    try {
      List<Plan> list = [];
      QuerySnapshot snapshot = await Firestore.instance
          .collection('Plan')
          .orderBy('plan', descending: true)
          .getDocuments();
      snapshot.documentChanges.forEach((DocumentChange doc) {
        print('entro');
        Plan plan = Plan.fromMap(doc.document.data);
        list.add(plan);
      });
      this._listPlan = list;
      notifyListeners();
    } catch (e) {
      print('error $e');
    }
  }
}
