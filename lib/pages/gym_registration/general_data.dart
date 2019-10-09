import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/material.dart' as prefix0;
import 'package:gym_go/model/gym_reg_model.dart';
import 'package:gym_go/model/user.dart';
import 'package:gym_go/service/firebase_storage.dart';
import 'package:gym_go/style/text.dart';
import 'package:gym_go/widget/button/button_add_gym.dart';
import 'package:gym_go/widget/button/button_next_gym.dart';
import 'package:gym_go/widget/picture_delete.dart';
import 'package:provider/provider.dart';
import 'package:gym_go/model/gym.dart';

class GeneralData extends StatefulWidget {
  @override
  _GeneralDataState createState() => _GeneralDataState();
}

class _GeneralDataState extends State<GeneralData> {
  final _formKey = GlobalKey<FormState>();
  bool _listValidate = false;
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
                '¿Cuáles son los datos de tu Gimnasio?',
                style: StylesText.textTitleRegGym,
              ),
              SizedBox(
                height: 32,
              ),
              TextFormField(
                initialValue:
                    gymRegModel.getGym != null ? gymRegModel.getGym.getName : '',
                onSaved: (value) => gymRegModel.name = value,
                validator: (value) {
                  if (value == '') {
                    return 'Por favor ingrese nombre';
                  }
                  return null;
                },
                decoration: InputDecoration(
                  labelText: 'Nombre',
                ),
              ),
              SizedBox(
                height: 32,
              ),
              TextFormField(
                initialValue: gymRegModel.getGym.phone ?? '',
                onSaved: (value) => gymRegModel.phone = value,
                validator: (value) {
                  if (value == '') {
                    return 'Por favor ingrese su celular';
                  }
                  return null;
                },
                decoration: InputDecoration(
                  labelText: 'Celular',
                ),
              ),
              SizedBox(
                height: 32,
              ),
              Text(
                '¿Cómo luce tu Gimnasio?',
                style: StylesText.textTitleRegGym,
              ),
              SizedBox(
                height: 8,
              ),
              Text(
                'Sube algunas fotos',
                style: StylesText.textSubtitleRegGym,
              ),
              SizedBox(
                height: 32,
              ),
              Container(
                height: 100,
                width: double.infinity,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        for (var picture in gymRegModel.getGym.picture)
                          PictureDelete(
                            url: picture.url,
                            onTap: () {
                              final index =
                                  gymRegModel.getGym.picture.indexOf(picture);
                              gymRegModel.deleteImage(index);
                            },
                          ),
                        gymRegModel.isLoading
                            ? Container(
                                height: 100,
                                width: 100,
                                child:
                                    Center(child: CircularProgressIndicator()),
                              )
                            : Container(),
                        ButtonAddGym(
                          size: 50,
                          color: Colors.blue,
                          onPressed: () {
                            showModalBottomSheet(
                                context: context,
                                backgroundColor: Colors.white,
                                builder: (BuildContext context) {
                                  return Container(
                                    child: Wrap(
                                      children: <Widget>[
                                        ListTile(
                                            leading:
                                                new Icon(Icons.photo_library),
                                            title: new Text('Galeria'),
                                            onTap: () => {
                                                  gymRegModel.uploadImage('galery')
                                                }),
                                        new ListTile(
                                          leading: new Icon(Icons.camera_alt),
                                          title: new Text('Cámara'),
                                          onTap: () =>
                                              {gymRegModel.uploadImage('camera')},
                                        ),
                                      ],
                                    ),
                                  );
                                });
                          },
                        ),
                      ],
                    )
                  ],
                ),
              ),
              _listValidate
                  ? Container(
                      margin: EdgeInsets.only(top: 8, left: 16),
                      child: Text(
                        'Sube al menos una foto',
                        style: TextStyle(
                            color: Theme.of(context).errorColor, fontSize: 12),
                      ),
                    )
                  : Container(),
              SizedBox(
                height: 32,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  
                  ButtonNextGym(
                    color: Colors.blue,
                    splashColor: Colors.white10,
                    radius: 30,
                    onTap: () {
                      // gymRegModel.nextPage();
                      if (_formKey.currentState.validate()) {
                        if (gymRegModel.getGym.picture.length == 0) {
                          setState(() {
                            _listValidate = true;
                          });
                        } else{
                          _formKey.currentState.save();
                          gymRegModel.nextPage();
                          }
                      } else if (gymRegModel.getGym.picture.length == 0) {
                        setState(() {
                          _listValidate = true;
                        });
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
