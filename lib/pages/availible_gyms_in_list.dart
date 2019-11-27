import 'package:flutter/material.dart';
import 'package:gym_go/model/gym.dart';
import 'package:gym_go/model/gym_model.dart';
import 'package:gym_go/model/suscription_model.dart';
import 'package:gym_go/widget/card_list_gym.dart';
import 'package:provider/provider.dart';

class AvailibleGymsInList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    GymModel gymModel = Provider.of(context);
    SubscriptionModel subscriptionModel = Provider.of(context);
    return _buildList(context, gymModel.availableGyms);

    
  }

  Widget _buildList(BuildContext context, List<Gym> availableGyms) {
    return ListView(
      padding: const EdgeInsets.only(top: 8.0),
      children: availableGyms.map((data) => CardListGym(gym: data, subs: true),).toList(),
    );
  }
}
