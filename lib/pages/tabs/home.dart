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
    return Scaffold(
        appBar: AppBar(
          title: Text('GymGo'),
          centerTitle: true,
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.tune),
              onPressed: (){
                
              },
            ),
            IconButton(
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
            )
          ],
        ),
        body: RefreshIndicator(
          onRefresh: () async {
            await gymModel.getGym();
          },
          child: _listState ? AvailibleGymsInList() : AvailibleGymsInMaps(),
        ));
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
