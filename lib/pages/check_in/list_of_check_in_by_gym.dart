import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:gym_go/model/check_in.dart';
import 'package:gym_go/model/suscripcion.dart';
import 'package:gym_go/service/firestore_document.dart';
import 'package:gym_go/widget/card_of_check_in_owner.dart';

class ListOfCheckInByGym extends StatelessWidget {
  final String gymId;
  final String userId;
  const ListOfCheckInByGym({Key key, this.gymId, this.userId})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Mis Check In'),
      ),
      body: _buildBody(context),
    );
  }

  Widget _buildBody(BuildContext context) {
    FirestoreDocument document = FirestoreDocument();
    return StreamBuilder<QuerySnapshot>(
      stream: userId == null
          ? document.getChechInByGymId(gymId)
          : document.getChechInByGymIdAndSuscription(gymId, userId),
      builder: (context, snapshot) {
        if (!snapshot.hasData)
          return Center(child: CircularProgressIndicator());

        return _buildList(context, snapshot.data.documents);
      },
    );
  }

  Widget _buildList(BuildContext context, List<DocumentSnapshot> snapshot) {
    if (snapshot.length == 0) {
      return Center(
        child: Text('Aún no tienes Clientes'),
      );
    }
    return GridView(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2, childAspectRatio: 25 / 20, crossAxisSpacing: 5),
      padding: const EdgeInsets.only(top: 8.0),
      children: snapshot.map((data) => _buildListItem(context, data)).toList(),
    );
  }

  Widget _buildListItem(BuildContext context, DocumentSnapshot data) {
    final checkIn = CheckIn.fromMap(data.data);

    return CardOfCheckInOwner(
      checkIn: checkIn,
      onTap: () {
        data.reference.updateData({'stateCheckIn': true});
      },
    );
  }
}
