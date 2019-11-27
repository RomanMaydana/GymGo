import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:gym_go/model/suscripcion.dart';
import 'package:gym_go/service/firestore_document.dart';

class ListOfSubscription extends StatelessWidget {
  final String gymId;

  const ListOfSubscription({Key key, this.gymId}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Suscripciones'),
      ),
      body: _buildBody(context),
    );
  }

  Widget _buildBody(BuildContext context) {
    FirestoreDocument document = FirestoreDocument();
    return StreamBuilder<QuerySnapshot>(
      stream: document.getSubscriptionForGymId(gymId),
      builder: (context, snapshot) {
        if (!snapshot.hasData) return CircularProgressIndicator();

        return _buildList(context, snapshot.data.documents);
      },
    );
  }

  Widget _buildList(BuildContext context, List<DocumentSnapshot> snapshot) {
    if (snapshot.length == 0) {
      return Center(
        child: Text('Aún no tienes Suscripciones'),
      );
    }
    return ListView(
      padding: const EdgeInsets.only(top: 8.0),
      children: snapshot.map((data) => _buildListItem(context, data)).toList(),
    );
  }

  Widget _buildListItem(BuildContext context, DocumentSnapshot data) {
    final subscription = Subscripcion.fromMap(data.data);

    return Padding(
      key: ValueKey(subscription.idSubscription),
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
      child: Container(
        padding: EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              blurRadius: 10,
              color: Colors.black12,
              offset: Offset(5, 5),
              spreadRadius: 2,
            )
          ],
          borderRadius: BorderRadius.circular(25.0),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Row(
              children: <Widget>[
                CircleAvatar(
                  child: Text('${subscription.nameUser[0].toUpperCase()}'),
                ),
                SizedBox(
                  width: 16,
                ),
                Expanded(
                  child: Text('${subscription.nameUser.toUpperCase()}'),
                ),
                IconButton(
                  onPressed: () {},
                  color: Colors.transparent,
                  icon: Icon(Icons.info_outline),
                )
              ],
            ),
            SizedBox(
              height: 8,
            ),
            Row(
              children: <Widget>[
                Expanded(
                  child: Text(
                    'De   ${subscription.initSubscription.day.toString().padLeft(2, '0')}/${subscription.initSubscription.month.toString().padLeft(2, '0')}/${subscription.initSubscription.year.toString()}     hasta    ${subscription.finalSubscription.day.toString().padLeft(2, '0')}/${subscription.finalSubscription.month.toString().padLeft(2, '0')}/${subscription.finalSubscription.year.toString()}',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 8,
            ),
            ButtonBar(
              alignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                FlatButton(
                  onPressed: () {},
                  child: Row(
                    children: <Widget>[
                      Icon(
                        Icons.call_received,
                        color: Colors.green,
                      ),
                      SizedBox(
                        width: 8,
                      ),
                      Text(
                        'Check In',
                        style: TextStyle(color: Colors.green),
                      )
                    ],
                  ),
                ),
                FlatButton(
                  onPressed: () {},
                  child: Row(
                    children: <Widget>[
                      Icon(
                        Icons.call_received,
                        color: Colors.orange,
                      ),
                      SizedBox(
                        width: 8,
                      ),
                      Text(
                        'Ver todo',
                        style: TextStyle(color: Colors.orange),
                      )
                    ],
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
