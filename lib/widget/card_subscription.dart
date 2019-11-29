import 'package:flutter/material.dart';
import 'package:gym_go/model/suscripcion.dart';
import 'package:gym_go/style/text.dart';
import 'package:liquid_progress_indicator/liquid_progress_indicator.dart';

import '../colors.dart';
import 'circle_color_decorator.dart';

class CardSubscription extends StatelessWidget {
  final Subscripcion subscripcion;

  const CardSubscription({Key key, this.subscripcion}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final date = DateTime.now();
    final time = subscripcion.finalSubscription
        .difference(subscripcion.initSubscription)
        .inDays;
    final timeQ = subscripcion.finalSubscription.difference(date).inDays;
    return Container(
      margin: EdgeInsets.all(16),
      padding: EdgeInsets.only(top: 8, left: 16, right: 8, bottom: 24),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              blurRadius: 10,
              color: Theme.of(context).primaryColor.withOpacity(0.2),
              offset: Offset(5, 5),
              spreadRadius: 2,
            ),
          ],
          color: Theme.of(context).primaryColor),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                subscripcion.plan ?? subscripcion.nameGym,
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w600),
              ),
              IconButton(
                icon: Icon(Icons.settings),
                onPressed: () {},
                color: Color.fromRGBO(104, 119, 149, 1),
              )
            ],
          ),
          SizedBox(
            height: 20,
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
                        '${subscripcion.initSubscription.day.toString().padLeft(2, '0')}/${subscripcion.initSubscription.month.toString().padLeft(2, '0')}/${subscripcion.initSubscription.year.toString()}',
                        style: TextStyle(color: Colors.white, fontSize: 20),
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
                        '${subscripcion.finalSubscription.day.toString().padLeft(2, '0')}/${subscripcion.finalSubscription.month.toString().padLeft(2, '0')}/${subscripcion.finalSubscription.year.toString()}',
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      )
                    ],
                  )
                ],
              ),
              Container(
                height: 100,
                width: 100,
                child: LiquidCircularProgressIndicator(
                  value: 1 - timeQ / time, // Defaults to 0.5.
                  valueColor: AlwaysStoppedAnimation(Theme.of(context)
                      .accentColor), // Defaults to the current Theme's accentColor.
                  backgroundColor: Colors
                      .white, // Defaults to the current Theme's backgroundColor.
                  borderColor: Theme.of(context).accentColor,
                  borderWidth: 5.0,
                  direction: Axis
                      .vertical, // The direction the liquid moves (Axis.vertical = bottom to top, Axis.horizontal = left to right). Defaults to Axis.vertical.
                  center: Text(
                    '${time - timeQ} días',
                    style: TextStyle(
                        color: Theme.of(context).primaryColor,
                        fontWeight: FontWeight.w600,
                        fontSize: 16),
                  ),
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
