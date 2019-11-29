import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:gym_go/model/check_in.dart';
import 'package:gym_go/service/firestore_document.dart';
import 'package:gym_go/widget/card_message_check_in.dart';

class MessageCheckIn extends StatelessWidget {
  final String id;
  final String picture;
  const MessageCheckIn({Key key, this.id, this.picture}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    FirestoreDocument firestoreDocument = FirestoreDocument();
    return Scaffold(
      appBar: AppBar(
        title: Text('Tienes un nuevo Check In'),
      ),
      body: Center(
        child: StreamBuilder(
          stream: firestoreDocument.getCheckInDocument(id),
          builder: (context, AsyncSnapshot<DocumentSnapshot> snapshot) {
            if (snapshot.hasData) {
              final CheckIn checkIn = CheckIn.fromMap(snapshot.data.data);

              return CardMessageCheckIn(
                checkIn: checkIn,
                picture: picture,
                onClick: () async {
                  await snapshot.data.reference.updateData({'stateCheckIn': true});
                  Navigator.of(context).pop();
                },
              );
            }
            return Center(child: CircularProgressIndicator());
          },
        ),
      ),
    );
  }
}
