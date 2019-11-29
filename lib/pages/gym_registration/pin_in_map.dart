import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:gym_go/class/var_globales.dart';
import 'package:gym_go/model/gym_model.dart';
import 'package:gym_go/model/gym_reg_model.dart';
import 'package:gym_go/model/user.dart';
import 'package:latlong/latlong.dart';
import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';
import 'package:flutter_svg/flutter_svg.dart';

class PinInMap extends StatefulWidget {
  final GymRegModel gymRegModel;
  final MapController mapController;
  const PinInMap({
    Key key,
    this.gymRegModel,
    this.mapController,
  }) : super(key: key);
  @override
  _PinInMapState createState() => _PinInMapState();
}

class _PinInMapState extends State<PinInMap> {
  MapController controller = MapController();
  List<LatLng> tappedPoints = [];

  _handleTap(LatLng latLng) {
    
    setState(() {
      tappedPoints = [];
      tappedPoints.add(latLng);
      widget.mapController.move(latLng, 13);
    });
    widget.gymRegModel.location = latLng;
  }

  @override
  void initState() {
    tappedPoints.add(widget.gymRegModel.getGym.location);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    UserModel userModel = Provider.of(context);

    return Scaffold(
      body: FlutterMap(
        options: new MapOptions(
          interactive: true,
          onTap: _handleTap,
          center: userModel.getCurrentLocation(),
          zoom: 13.0,
        ),
        mapController: controller,
        layers: [
          new TileLayerOptions(
            //  urlTemplate: 'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
            urlTemplate: "https://api.tiles.mapbox.com/v4/"
                "{id}/{z}/{x}/{y}@2x.png?access_token={accessToken}",
            additionalOptions: {
              'accessToken': VarGlobales.mapKey,
              'id': 'mapbox.streets',
            },

            // subdomains: ["a","b","c"]
          ),
          new MarkerLayerOptions(
            markers: [
              Marker(
                anchorPos: AnchorPos.align(AnchorAlign.top),
                width: 30.0,
                height: 30.0,
                point: userModel.getCurrentLocation(),
                builder: (ctx) => new Container(
                  height: 10,
                  width: 10,
                  child: new SvgPicture.asset('images/my_location.svg'),
                ),
              ),
              for (LatLng marker in tappedPoints)
                Marker(
                  anchorPos: AnchorPos.align(AnchorAlign.top),
                  width: 30.0,
                  height: 30.0,
                  point: marker,
                  builder: (ctx) => new Container(
                    child: new SvgPicture.asset('images/pin.svg'),
                  ),
                )
            ],
          ),
        ],
      ),
    );
  }
}
