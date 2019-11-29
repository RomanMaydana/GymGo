import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:gym_go/model/check_in.dart';
import 'package:gym_go/model/suscripcion.dart';
import 'package:gym_go/service/firestore_document.dart';
import 'package:gym_go/widget/card_message_check_in.dart';
import 'package:gym_go/widget/card_subscription.dart';

class MessageSuscription extends StatelessWidget {
  final String id;
  
  const MessageSuscription({Key key, this.id}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    FirestoreDocument firestoreDocument = FirestoreDocument();
    return Scaffold(
      appBar: AppBar(title: Text('Tienes una nueva Suscripción')),
      body: Center(
        child: StreamBuilder(
          stream: firestoreDocument.getSubscriptionDocument(id),
          builder: (context, AsyncSnapshot<DocumentSnapshot> snapshot) {
            if (snapshot.hasData) {
              final Subscripcion subscripcion =
                  Subscripcion.fromMap(snapshot.data.data);

              return CardSubscription(
                subscripcion: subscripcion,
              );
            }
            return Center(child: CircularProgressIndicator());
          },
        ),
      ),
    );
  }
}
