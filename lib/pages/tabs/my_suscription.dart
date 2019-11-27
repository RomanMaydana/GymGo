import 'package:flutter/material.dart';
import 'package:gym_go/class/my_check_in_argument.dart';
import 'package:gym_go/model/suscription_model.dart';
import 'package:gym_go/model/user.dart';
import 'package:gym_go/widget/card_subscription.dart';
import 'package:provider/provider.dart';

class MySubscriptionTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SubscriptionModel subscriptionModel = Provider.of(context);
    UserModel userModel = Provider.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Mis Suscripciones'),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.open_in_new,
              color: Theme.of(context).accentColor,
            ),
            onPressed: () {
              Navigator.of(context).pushNamed('/mycheckin',
                  arguments:
                      MyCheckInArgument(userId: userModel.getUser().userId));
            },
          )
        ],
      ),
      // body: CardSubscription(),
      body: ListView(
        children: subscriptionModel.availableSubs
            .map((subscripcion) => CardSubscription(
                  subscripcion: subscripcion,
                ))
            .toList(),
      ),
    );
  }
}
