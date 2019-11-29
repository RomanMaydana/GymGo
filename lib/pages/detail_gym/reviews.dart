import 'package:flutter/material.dart';
import 'package:gym_go/colors.dart';
import 'package:gym_go/model/gym.dart';

class Reviews extends StatelessWidget {
  final Gym gym;

  const Reviews({Key key, this.gym}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(32),
            child: TextField(
              decoration: InputDecoration(
                contentPadding: EdgeInsets.only(left: 15.0, top: 25.0),
                border: OutlineInputBorder(borderSide: BorderSide(width: 0.1)),
                focusedBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(width: 1, color: ColorPalette.black959DAD)),
                focusColor: Colors.red,
                enabledBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(width: 1, color: ColorPalette.blackEEEEEE)),
              ),
            ),
          )
        ],
      ),
    );
  }
}
