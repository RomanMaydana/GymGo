import 'dart:math';

import 'package:flutter/material.dart';
import 'package:gym_go/class/detail_gym_page_arguments.dart';
import 'package:gym_go/model/gym.dart';
import 'package:gym_go/pages/detail_gym/detail_gym.dart';

class DetailGymPage extends StatelessWidget {
  final Gym gym;
  final bool subs;
  const DetailGymPage({Key key, this.gym, this.subs}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          DetailGym(
            gym: gym,
            subs: subs,
          ),
          subs
              ? Align(
                  alignment: Alignment.bottomCenter,
                  child: GestureDetector(
                    onTap: () {

                    },
                    child: Container(
                      margin: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Theme.of(context).primaryColor,
                      ),
                      height: 50,
                      width: double.infinity,
                      alignment: Alignment.center,
                      child: Text('Check In',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.w700)),
                    ),
                  ),
                )
              : Container()
        ],
      ),
    );
  }
}
