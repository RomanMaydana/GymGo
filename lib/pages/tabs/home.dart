import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gym_go/model/gym_model.dart';
import 'package:gym_go/model/suscription_model.dart';
import 'package:gym_go/model/user.dart';
import 'package:gym_go/pages/availible_gyms_in_list.dart';
import 'package:provider/provider.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import '../availible_gyms_in_map.dart';

class HomeTab extends StatefulWidget {
  @override
  _HomeTabState createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> with AutomaticKeepAliveClientMixin {
  bool _listState = true;
  @override
  Widget build(BuildContext context) {
    GymModel gymModel = Provider.of(context);
    return Stack(
      children: <Widget>[
        Column(
          children: <Widget>[
            Expanded(
              child: Container(
                color: Theme.of(context).primaryColor,
              ),
            )
          ],
        ),
        Positioned(
          left: -100,
          top: -100,
          child: Container(
            height: 200,
            width: 200,
            decoration: BoxDecoration(
                color: Theme.of(context).accentColor,
                borderRadius: BorderRadius.circular(100)),
          ),
        ),
        Positioned(
          right: -50,
          top: -50,
          child: Container(
            height: 260,
            width: 260,
            decoration: BoxDecoration(
                color: Theme.of(context).accentColor.withOpacity(0.2),
                borderRadius: BorderRadius.circular(130)),
          ),
        ),
        Positioned(
          right: 50,
          top: -40,
          child: Container(
            height: 120,
            width: 120,
            decoration: BoxDecoration(
                color: Theme.of(context).accentColor.withOpacity(0.5),
                borderRadius: BorderRadius.circular(60)),
          ),
        ),
        Positioned(
          right: 40,
          top: -20,
          child: Container(
            height: 80,
            width: 80,
            decoration: BoxDecoration(
                color: Theme.of(context).accentColor,
                borderRadius: BorderRadius.circular(40)),
          ),
        ),
        Column(
          children: <Widget>[
            Container(
                height: 120,
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: Center(
                        child: Text(
                          'Gym Go',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 28,
                              fontWeight: FontWeight.w700),
                        ),
                      ),
                    ),
                    CircleAvatar(
                      backgroundColor: Colors.white,
                      child: IconButton(
                        onPressed: () {
                          setState(() {
                            _listState = !_listState;
                          });
                        },
                        icon: SvgPicture.asset(
                          'images/pin.svg',
                          height: 20,
                          color: _listState ? Colors.black26 : null,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 16,
                    )
                  ],
                )),
            Expanded(
              child: Container(
                padding: EdgeInsets.only(top: 16),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20))),
                child: RefreshIndicator(
                  onRefresh: () async {
                    await gymModel.getGym();
                  },
                  child: _listState
                      ? AvailibleGymsInList()
                      : AvailibleGymsInMaps(),
                ),
              ),
            )
          ],
        ),
      ],
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
