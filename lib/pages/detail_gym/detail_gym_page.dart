import 'dart:math';

import 'package:flutter/material.dart';
import 'package:gym_go/class/detail_gym_page_arguments.dart';
import 'package:gym_go/class/gym_registration.dart';
import 'package:gym_go/class/shopping_page.dart';
import 'package:gym_go/model/gym.dart';
import 'package:gym_go/model/suscripcion.dart';
import 'package:gym_go/model/suscription_model.dart';
import 'package:gym_go/model/user.dart';
import 'package:gym_go/pages/check_in/list_of_check_in_by_gym.dart';
import 'package:gym_go/pages/detail_gym/detail_gym.dart';
import 'package:gym_go/pages/detail_gym/subscription/list_of_subscription.dart';
import 'package:gym_go/widget/button/fab_with_icons.dart';

import 'package:gym_go/widget/button/layout.dart';
import 'package:provider/provider.dart';

class DetailGymPage extends StatelessWidget {
  final Gym gym;
  final bool subs;
  const DetailGymPage({Key key, this.gym, this.subs = false}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    SubscriptionModel subscriptionModel = Provider.of(context);
    UserModel userModel = Provider.of(context);
    bool button = false;
    Subscripcion subscripcion;
    if (this.subs) {
      subscripcion =
          subscriptionModel.verifySubscriptionInGym(gym.gymId, gym.plan);
      if (subscripcion != null) button = true;
    }

    return Scaffold(
      floatingActionButton: this.subs
          ? GestureDetector(
              onTap: !button
                  ? () {
                      Navigator.pushNamed(context, '/shopping',
                          arguments: ShoppingPageArguments(gym: this.gym));
                    }
                  : () {
                      subscriptionModel
                          .registredCheckIn(
                              subscripcion, gym, userModel.getUser())
                          .then((v) {
                        Navigator.pop(context);
                      });
                    },
              child: Container(
                margin: EdgeInsets.only(left: 32),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  color: button ? Colors.green : Colors.orange,
                ),
                height: 40,
                width: double.infinity,
                alignment: Alignment.center,
                child: Text(button ? 'Check In' : 'Suscribir',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.w500)),
              ),
            )
          : _buildFab(context),
      body: DetailGym(
        gym: gym,
        subs: subs,
      ),
    );
  }

  Widget _buildFab(BuildContext context) {
    final icons = [Icons.playlist_add_check, Icons.open_in_new, Icons.edit];
    return AnchoredOverlay(
      showOverlay: true,
      overlayBuilder: (context, offset) {
        return CenterAbout(
          position: Offset(offset.dx, offset.dy - icons.length * 35.0),
          child: FabWithIcons(
            icons: icons,
            onIconTapped: (int nro) {
              if (nro == 0) {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ListOfSubscription(
                              gymId: this.gym.gymId,
                            )));
              } else if (nro == 1) {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ListOfCheckInByGym(
                              gymId: this.gym.gymId,
                            )));
              } else {
                Navigator.pushReplacementNamed(context, '/gymregistration',
                    arguments: GymRegistrationArguments(gym: gym));
              }
            },
          ),
        );
      },
      child: FloatingActionButton(
        onPressed: () {},
        tooltip: 'Opciones',
        child: Icon(Icons.add),
        elevation: 2.0,
      ),
    );
  }
}
