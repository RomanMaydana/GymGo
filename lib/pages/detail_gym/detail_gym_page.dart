import 'dart:math';

import 'package:flutter/material.dart';
import 'package:gym_go/class/detail_gym_page_arguments.dart';
import 'package:gym_go/model/gym.dart';
import 'package:gym_go/pages/detail_gym/detail_gym.dart';

class DetailGymPage extends StatelessWidget {
  final Gym gym;

  const DetailGymPage({Key key, this.gym}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DetailGym(
        gym: gym,
      ),
    );
  }
}
