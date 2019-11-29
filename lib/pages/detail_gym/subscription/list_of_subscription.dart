import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:gym_go/model/suscripcion.dart';
import 'package:gym_go/pages/check_in/list_of_check_in_by_gym.dart';
import 'package:gym_go/service/firestore_document.dart';
import 'package:gym_go/widget/circle_color_decorator.dart';

import '../../../colors.dart';

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
        padding: EdgeInsets.all(16),
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
                  child: Text(
                    '${subscription.nameUser}',
                    style: TextStyle(
                        color: Theme.of(context).primaryColor,
                        fontSize: 20,
                        fontWeight: FontWeight.w600),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 16,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        CircleColorDecorator(
                          color: ColorPalette.lightBlue,
                          size: 10,
                        ),
                        SizedBox(
                          width: 8,
                        ),
                        Text(
                          'Inicia',
                          style: TextStyle(
                              color: Color.fromRGBO(104, 119, 149, 1),
                              fontSize: 16,
                              fontWeight: FontWeight.w600),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Row(
                      children: <Widget>[
                        SizedBox(
                          width: 18,
                        ),
                        Text(
                          '${subscription.initSubscription.day.toString().padLeft(2, '0')}/${subscription.initSubscription.month.toString().padLeft(2, '0')}/${subscription.initSubscription.year.toString()}',
                          style: TextStyle(color: Colors.black, fontSize: 18),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    Row(
                      children: <Widget>[
                        CircleColorDecorator(
                          color: Theme.of(context).accentColor,
                          size: 10,
                        ),
                        SizedBox(
                          width: 8,
                        ),
                        Text(
                          'Finaliza',
                          style: TextStyle(
                              color: Color.fromRGBO(104, 119, 149, 1),
                              fontSize: 16,
                              fontWeight: FontWeight.w600),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Row(
                      children: <Widget>[
                        SizedBox(
                          width: 18,
                        ),
                        Text(
                          '${subscription.finalSubscription.day.toString().padLeft(2, '0')}/${subscription.finalSubscription.month.toString().padLeft(2, '0')}/${subscription.finalSubscription.year.toString()}',
                          style: TextStyle(color: Colors.black, fontSize: 18),
                        )
                      ],
                    )
                  ],
                ),
                Column(
                  children: <Widget>[
                    FlatButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ListOfCheckInByGym(
                                      gymId: gymId,
                                      userId: subscription.idUser,
                                    )));
                      },
                      child: Row(
                        children: <Widget>[
                          Icon(
                            Icons.transit_enterexit,
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
                      onPressed: () async{
                        await data.reference.delete();
                      },
                      child: Row(
                        children: <Widget>[
                          Icon(
                            Icons.close,
                            color: Colors.red,
                          ),
                          SizedBox(
                            width: 8,
                          ),
                          Text(
                            'Cancelar',
                            style: TextStyle(color: Colors.orange),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
