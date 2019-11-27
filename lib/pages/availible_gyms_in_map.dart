import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gym_go/class/var_globales.dart';
import 'package:gym_go/model/gym.dart';
import 'package:gym_go/model/gym_model.dart';
import 'package:gym_go/model/suscription_model.dart';
import 'package:gym_go/model/user.dart';
import 'package:gym_go/widget/card_list_gym.dart';
import 'package:latlong/latlong.dart';
import 'package:provider/provider.dart';

class AvailibleGymsInMaps extends StatefulWidget {
  @override
  _AvailibleGymsInMapsState createState() => _AvailibleGymsInMapsState();
}

class _AvailibleGymsInMapsState extends State<AvailibleGymsInMaps> {
  bool _stateClick = false;
  Gym _gym = null;
  _handleTap(LatLng latLng) {}

  @override
  Widget build(BuildContext context) {
    UserModel userModel = Provider.of(context);
    GymModel gymModel = Provider.of(context);
    SubscriptionModel subscriptionModel = Provider.of(context);
    return Stack(
      children: <Widget>[
        Container(
          child: FlutterMap(
            options: MapOptions(
              interactive: true,
              onTap: _handleTap,
              center: userModel.getCurrentLocation(),
              zoom: 13.0,
            ),
            mapController: MapController(),
            layers: [
              TileLayerOptions(
                //  urlTemplate: 'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
                urlTemplate: "https://api.tiles.mapbox.com/v4/"
                    "{id}/{z}/{x}/{y}@2x.png?access_token={accessToken}",
                additionalOptions: {
                  'accessToken': VarGlobales.mapKey,
                  'id': 'mapbox.streets',
                },

                // subdomains: ["a","b","c"]
              ),
              MarkerLayerOptions(markers: [
                for (Gym gym in gymModel.availableGyms)
                  Marker(
                    anchorPos: AnchorPos.align(AnchorAlign.top),
                    width: 30.0,
                    height: 30.0,
                    point: gym.location,
                    builder: (ctx) => GestureDetector(
                      onTap: () {
                        setState(() {
                          _stateClick = true;
                          _gym = gym;
                        });
                      },
                      child: new Container(
                        child: new SvgPicture.asset('images/pin.svg'),
                      ),
                    ),
                  )
              ])
            ],
          ),
        ),
        _stateClick
            ? Align(
                alignment: Alignment.bottomCenter,
                child: CardListGym(
                  gym: _gym,
                  subs: true,
                ),
              )
            : Container()
      ],
    );
  }
}
