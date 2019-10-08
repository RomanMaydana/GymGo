import 'package:flutter/material.dart';
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
                    Column(
                      children: <Widget>[
                        Text(
                          '${gym.city}, ${gym.zone}, ${gym.streetOrAvenue}',
                          style: StylesText.textBlack14w300,
                        ),
                        RaisedButton(
                          color: Colors.white,
                          splashColor: Theme.of(context).primaryColor,
                          highlightColor: Colors.transparent,
                          elevation: 0,
                          onPressed: () {},
                          shape: Border.all(
                            width: 0.5,
                            color: Theme.of(context).accentColor,
                          ),
                          child: Text(
                            'Navegar por el Mapa',
                            style:
                                TextStyle(color: Theme.of(context).accentColor),
                          ),
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
                        Text(
                          gym.state ? 'Activo' : 'Inactivo',
                          style: StylesText.textBlack14w300,
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
