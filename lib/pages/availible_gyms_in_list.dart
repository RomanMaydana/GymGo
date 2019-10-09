import 'package:flutter/material.dart';
import 'package:gym_go/model/gym.dart';
import 'package:gym_go/model/gym_model.dart';
import 'package:gym_go/widget/card_list_gym.dart';
import 'package:provider/provider.dart';

class AvailibleGymsInList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    GymModel gymModel = Provider.of(context);
    return Column(
      children: <Widget>[
        for (Gym gym in gymModel.availableGyms)
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 32, vertical: 8),
            child: CardListGym(gym: gym),
          )
      ],
    );
  }
}