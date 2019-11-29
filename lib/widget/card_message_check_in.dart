import 'package:flutter/material.dart';
import 'package:gym_go/model/check_in.dart';

import 'button/button_next_gym.dart';

class CardMessageCheckIn extends StatelessWidget {
  final CheckIn checkIn;
  final String picture;
  final Function onClick;
  const CardMessageCheckIn({Key key, this.checkIn, this.picture, this.onClick})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        // alignment: Alignment(50, 0),

        children: <Widget>[
          Container(
            margin: EdgeInsets.only(top: 32),
            padding: EdgeInsets.only(top: 64, bottom: 32, left: 32, right: 32),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    blurRadius: 10,
                    color: Theme.of(context).primaryColor.withOpacity(0.2),
                    offset: Offset(5, 5),
                    spreadRadius: 2,
                  )
                ]),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text(
                  checkIn.nameUser,
                  style: TextStyle(fontSize: 28, fontWeight: FontWeight.w600),
                ),
                SizedBox(
                  height: 16,
                ),
                Text(
                  '${checkIn.creationDate.hour.toString().padLeft(2, '0')}:${checkIn.creationDate.minute.toString().padLeft(2, '0')}',
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
                SizedBox(
                  height: 8,
                ),
                Text(
                  '${checkIn.creationDate.day.toString().padLeft(2, '0')}/${checkIn.creationDate.month.toString().padLeft(2, '0')}/${checkIn.creationDate.year.toString()}',
                ),
                SizedBox(
                  height: 32,
                ),
                ButtonNextGym(
                  child: Text(
                    'Check In',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w700),
                  ),
                  color: Colors.green,
                  onTap: onClick,
                  splashColor: Colors.white,
                  radius: 30,
                )
              ],
            ),
          ),
          Positioned(
            left: 32,
            // top: -30,
            child: Container(
              height: 70,
              width: 70,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  image: DecorationImage(
                    image: NetworkImage(picture ??
                        'https://image.freepik.com/vector-gratis/perfil-avatar-hombre-icono-redondo_24640-14044.jpg'),
                  )),
            ),
          )
        ],
      ),
    );
  }
}
