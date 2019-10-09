import 'package:flutter/material.dart';
import 'package:gym_go/model/gym.dart';

class Reviews extends StatelessWidget {
  final Gym gym;

  const Reviews({Key key, this.gym}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[],
      ),
    );
  }
}
