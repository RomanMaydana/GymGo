import 'package:flutter/material.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:gym_go/model/gym.dart';
import 'package:gym_go/model/gym_model.dart';
import 'package:gym_go/model/suscripcion.dart';
import 'package:gym_go/pages/check_in/list_of_check_in_by_gym.dart';
import 'package:gym_go/service/firestore_document.dart';
import 'package:gym_go/widget/card_list_gym.dart';
import 'package:gym_go/widget/circle_color_decorator.dart';

class ListOfGymByPlan extends StatelessWidget {
  final String plan;

  const ListOfGymByPlan({Key key, this.plan}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Gimnasios ${plan}'),
      ),
      body: _buildBody(context),
    );
  }

  Widget _buildBody(BuildContext context) {
    FirestoreDocument document = FirestoreDocument();
    return StreamBuilder<QuerySnapshot>(
      stream: document.getGymyByPlan(plan),
      builder: (context, snapshot) {
        if (!snapshot.hasData) return CircularProgressIndicator();

        return _buildList(context, snapshot.data.documents);
      },
    );
  }

  Widget _buildList(BuildContext context, List<DocumentSnapshot> snapshot) {
    if (snapshot.length == 0) {
      return Center(
        child: Text('Aún no hay Gimnasios de Plan ${plan}'),
      );
    }
    return ListView(
      padding: const EdgeInsets.only(top: 8.0),
      children: snapshot.map((data) => _buildListItem(context, data)).toList(),
    );
  }

  Widget _buildListItem(BuildContext context, DocumentSnapshot data) {
    final Gym gym = Gym.fromMap(data.data);

    return CardListGym(gym: gym, subs: true);
  }
}
