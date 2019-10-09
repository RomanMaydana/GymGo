import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gym_go/class/var_globales.dart';
import 'package:gym_go/model/gym.dart';
import 'package:gym_go/style/text.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class Information extends StatelessWidget {
  final Gym gym;
  Information({Key key, @required this.gym}) : super(key: key);

  bool click;
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.all(32),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              'Datos Generales',
              style: StylesText.textTitleRegGym,
            ),
            SizedBox(
              height: 16,
            ),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Icon(
                      Icons.phone,
                      color: Theme.of(context).accentColor,
                    ),
                    SizedBox(
                      width: 16,
                    ),
                    Column(
                      children: <Widget>[
                        Text(
                          'Contacto',
                          style: StylesText.textBlack14w500,
                        ),
                        Text(
                          gym.phone,
                          style: StylesText.textBlack14w300,
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 16,
            ),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Icon(
                      Icons.notifications_active,
                      color: Theme.of(context).accentColor,
                    ),
                    SizedBox(
                      width: 16,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          'Estado',
                          style: StylesText.textBlack14w500,
                        ),
                        gym.state
                            ? Text(
                                'Activo',
                                style: TextStyle(
                                    color: Colors.green,
                                    fontSize: 14.0,
                                    fontWeight: FontWeight.w300),
                              )
                            : Text(
                                'Inactivo',
                                style: TextStyle(
                                    color: Colors.red,
                                    fontSize: 14.0,
                                    fontWeight: FontWeight.w300),
                              )
                      ],
                    )
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 32,
            ),
            Text(
              'Dirección',
              style: StylesText.textTitleRegGym,
            ),
            SizedBox(
              height: 16,
            ),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Icon(
                      MdiIcons.pin,
                      color: Theme.of(context).accentColor,
                    ),
                    SizedBox(
                      width: 16,
                    ),
                    Text(
                      '${gym.city}, ${gym.zone}, ${gym.streetOrAvenue}',
                      style: StylesText.textBlack14w300,
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 16,
            ),
            Container(
              height: 200,
              width: double.infinity,
              child: FlutterMap(
                  options: MapOptions(
                      interactive: true, center: gym.location, zoom: 15),
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
                        point: gym.location,
                        builder: (ctx) => new Container(
                          child: new SvgPicture.asset('images/pin.svg'),
                        ),
                      )
                    ])
                  ]),
            ),
            SizedBox(
              height: 32,
            ),
            Text(
              '¿Qué ofrece?',
              style: StylesText.textTitleRegGym,
            ),
            SizedBox(
              height: 16,
            ),
            Text(
              'Clases',
              style: StylesText.textBlack14w500,
            ),
            Wrap(
              spacing: 8,
              direction: Axis.horizontal,
              children: gym.classes
                  .map((cls) => Chip(
                        label: Text(cls),
                        elevation: 1,
                        backgroundColor:
                            Theme.of(context).accentColor.withOpacity(0.1),
                      ))
                  .toList(),
            ),
            SizedBox(
              height: 16,
            ),
            Text(
              'Servicios',
              style: StylesText.textBlack14w500,
            ),
            SizedBox(
              height: 8,
            ),
            Wrap(
              spacing: 8,
              direction: Axis.horizontal,
              children: gym.service
                  .map((service) => Tooltip(
                        message: service,
                        child: Chip(
                            elevation: 1,
                            backgroundColor:
                                Theme.of(context).accentColor.withOpacity(0.1),
                            label: Icon(VarGlobales.iconService[service],
                                color: Colors.black54)),
                      ))
                  .toList(),
            ),
            SizedBox(
              height: 16,
            ),
          ],
        ),
      ),
    );
  }
}
