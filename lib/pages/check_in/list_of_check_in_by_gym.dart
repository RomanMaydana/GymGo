import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:gym_go/model/check_in.dart';
import 'package:gym_go/model/suscripcion.dart';
import 'package:gym_go/service/firestore_document.dart';

class ListOfCheckInByGym extends StatelessWidget {
  final String gymId;

  const ListOfCheckInByGym({Key key, this.gymId}) : super(key: key);
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
      stream: document.getChechInByGymId(gymId),
      builder: (context, snapshot) {
        if (!snapshot.hasData) return CircularProgressIndicator();

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
    return ListView(
      padding: const EdgeInsets.only(top: 8.0),
      children: snapshot.map((data) => _buildListItem(context, data)).toList(),
    );
  }

  Widget _buildListItem(BuildContext context, DocumentSnapshot data) {
    final checkIn = CheckIn.fromMap(data.data);

    return Padding(
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
                  child: Text('${checkIn.nameUser[0].toUpperCase()}'),
                ),
                SizedBox(
                  width: 16,
                ),
                Expanded(
                  child: Text('${checkIn.nameUser.toUpperCase()}'),
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
                    '${checkIn.creationDate.hour.toString().padLeft(2,'0')}:${checkIn.creationDate.minute.toString().padLeft(2,'0')}   ${checkIn.creationDate.day.toString().padLeft(2, '0')}/${checkIn.creationDate.month.toString().padLeft(2, '0')}/${checkIn.creationDate.year.toString()}',
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
                !checkIn.stateCheckIn
                    ? FlatButton(
                        onPressed: () async {
                          await data.reference
                              .updateData({'stateCheckIn': true});
                        },
                        child: Row(
                          children: <Widget>[
                            Icon(
                              Icons.open_in_new,
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
                      )
                    : Container(),
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
