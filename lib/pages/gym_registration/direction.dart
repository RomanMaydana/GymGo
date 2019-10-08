import 'package:flutter/material.dart';
import 'package:gym_go/model/gym_reg_model.dart';
import 'package:gym_go/model/user.dart';
import 'package:gym_go/style/text.dart';
import 'package:gym_go/widget/button/button_next_gym.dart';
import 'package:provider/provider.dart';

class Direction extends StatefulWidget {
  @override
  _DirectionState createState() => _DirectionState();
}

class _DirectionState extends State<Direction> {
  final _formKey = GlobalKey<FormState>();
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
              Container(
                child: Text('Mapa'),
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
                    onTap: (){
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
