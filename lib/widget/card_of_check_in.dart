import 'package:flutter/material.dart';
import 'package:gym_go/model/check_in.dart';

class CardOfCheckIn extends StatelessWidget {
  final Function onTap;
  final CheckIn checkIn;
  const CardOfCheckIn({Key key, @required this.onTap, @required this.checkIn})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    double radius = 10;
    return Container(
      margin: EdgeInsets.all(8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          Expanded(
            child: Container(
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                  border: Border.all(
                      color: Theme.of(context).accentColor, width: 0.1),
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(radius),
                      bottomLeft: Radius.circular(radius),
                      topRight: Radius.circular(radius)),
                  // color: Colors.red,
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      blurRadius: 5,
                      color: Theme.of(context).primaryColor.withOpacity(0.2),
                      offset: Offset(-2, 2),
                      spreadRadius: 0.1,
                    )
                  ]),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Text(
                    checkIn.nameGym,
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.w700),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Text(
                    '${checkIn.creationDate.hour.toString().padLeft(2, '0')}:${checkIn.creationDate.minute.toString().padLeft(2, '0')}',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.w500),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Text(
                    '${checkIn.creationDate.day.toString().padLeft(2, '0')}/${checkIn.creationDate.month.toString().padLeft(2, '0')}/${checkIn.creationDate.year.toString()}',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 14,
                        fontWeight: FontWeight.w300),
                  ),
                ],
              ),
            ),
          ),
          GestureDetector(
            onTap: !checkIn.stateCheckIn ? onTap : () {},
            child: Container(
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: checkIn.stateCheckIn
                    ? Colors.green
                    : Theme.of(context).accentColor,
                borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(radius),
                    topRight: Radius.circular(radius)),
              ),
              child: RotatedBox(
                quarterTurns: 45,
                child: Text(
                  checkIn.stateCheckIn ? 'Check In' : 'Cancelar',
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
