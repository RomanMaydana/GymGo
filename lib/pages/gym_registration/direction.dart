import 'package:flutter/material.dart';
import 'package:flutter_map/plugin_api.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gym_go/class/var_globales.dart';
import 'package:gym_go/model/gym_reg_model.dart';
import 'package:gym_go/model/user.dart';
import 'package:gym_go/pages/gym_registration/pin_in_map.dart';
import 'package:gym_go/style/text.dart';
import 'package:gym_go/widget/button/button_next_gym.dart';
import 'package:provider/provider.dart';
import 'package:flutter_map/flutter_map.dart';

class Direction extends StatefulWidget {
  @override
  _DirectionState createState() => _DirectionState();
}

class _DirectionState extends State<Direction> {
  final _formKey = GlobalKey<FormState>();
  MapController mapController = MapController();

  @override
  void initState() {
    
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    GymRegModel gymRegModel = Provider.of(context);
    UserModel userModel = Provider.of(context);
    return Form(
      key: _formKey,
      child: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(32),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                '¿Dónde se encuentra tu Gimnasio?',
                style: StylesText.textTitleRegGym,
              ),
              SizedBox(
                height: 32,
              ),
              TextFormField(
                initialValue: gymRegModel.getGym.zone,
                onSaved: (value) => gymRegModel.zone = value,
                validator: (value) {
                  if (value.trim() == '') {
                    return 'Ingrese la Zona.';
                  }
                  return null;
                },
                decoration: InputDecoration(
                  labelText: 'Zona',
                ),
              ),
              SizedBox(
                height: 32,
              ),
              TextFormField(
                initialValue: gymRegModel.getGym.streetOrAvenue,
                onSaved: (value) => gymRegModel.streetOrAvenue = value,
                validator: (value) {
                  if (value == '') {
                    return 'Ingrese la Avenida o Calle.';
                  }
                  return null;
                },
                decoration: InputDecoration(
                  labelText: 'Calle',
                ),
              ),
              SizedBox(
                height: 32,
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => PinInMap(
                                gymRegModel: gymRegModel,
                                mapController: mapController
                              )));
                },
                child: Container(
                  height: 200,
                  width: double.infinity,
                  child: FlutterMap(
                      options: MapOptions(
                        interactive: false,
                        center: gymRegModel.getGym.location,
                        debug: true,
                        
                        zoom: 13
                      ),
                      mapController: 
                        mapController
                      ,
                      layers: [
                        TileLayerOptions(
                          urlTemplate: "https://api.tiles.mapbox.com/v4/"
                              "{id}/{z}/{x}/{y}@2x.png?access_token={accessToken}",
                          additionalOptions: {
                            'accessToken': VarGlobales.mapKey,
                            'id': 'mapbox.streets',
                          },
                        ),
                        MarkerLayerOptions(markers: [
                          Marker(
                            anchorPos: AnchorPos.align(AnchorAlign.top),
                            width: 30.0,
                            height: 30.0,
                            point: gymRegModel.getGym.location,
                            builder: (ctx) => new Container(
                              child: new SvgPicture.asset('images/pin.svg'),
                            ),
                          )
                        ])
                      ]),
                ),
              ),
              SizedBox(
                height: 32,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  ButtonNextGym(
                    color: Colors.white,
                    splashColor: Colors.blue,
                    radius: 30,
                    onTap: () {
                      _formKey.currentState.save();
                      gymRegModel.previousPage();
                    },
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Icon(
                          Icons.keyboard_arrow_left,
                          color: Colors.black26,
                        ),
                        SizedBox(
                          width: 8,
                        ),
                        Text(
                          'Anterior',
                          style: TextStyle(
                              color: Colors.black26,
                              fontWeight: FontWeight.w600,
                              fontSize: 14),
                        ),
                        SizedBox(
                          width: 4,
                        )
                      ],
                    ),
                  ),
                  ButtonNextGym(
                    color: Colors.blue,
                    splashColor: Colors.white10,
                    radius: 30,
                    onTap: () {
                      if (_formKey.currentState.validate()) {
                        _formKey.currentState.save();
                        gymRegModel.nextPage();
                      }
                    },
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        SizedBox(
                          width: 4,
                        ),
                        Text(
                          'Siguiente',
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                              fontSize: 14),
                        ),
                        SizedBox(
                          width: 8,
                        ),
                        Icon(
                          Icons.keyboard_arrow_right,
                          color: Colors.white,
                        )
                      ],
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
