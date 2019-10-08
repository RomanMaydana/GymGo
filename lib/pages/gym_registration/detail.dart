import 'package:flutter/material.dart';
import 'package:gym_go/model/gym_model.dart';
import 'package:gym_go/model/gym_reg_model.dart';
import 'package:gym_go/model/user.dart';
import 'package:gym_go/style/text.dart';
import 'package:gym_go/widget/button/button_next_gym.dart';
import 'package:provider/provider.dart';

class Detail extends StatefulWidget {
  @override
  _DetailState createState() => _DetailState();
}

class _DetailState extends State<Detail> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    GymRegModel gymRegModel = Provider.of(context);
    GymModel gymModel = Provider.of(context);
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
                        '¿Cúal es la tarifa mensual que cobraras?',
                        style: StylesText.textTitleRegGym,
                      ),
                      SizedBox(
                        height: 32,
                      ),
                      TextFormField(
                        initialValue: gymRegModel.getGym.price.toString() ?? '',
                        keyboardType: TextInputType.number,
                        onSaved: (value) =>
                            gymRegModel.price = double.parse(value),
                        validator: (value) {
                          if (value == '') {
                            return 'Ingrese tarifa a cobrar.';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          labelText: 'Precio en Bolivianos',
                        ),
                      ),
                      SizedBox(
                        height: 32,
                      ),
                      Text(
                        'Membresía GymGo',
                        style: StylesText.textTitleRegGym,
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      Text(
                        'Forma parte del modelo de negocio de Suscripción, eligiendo un Plan (basic, medium, premium) para tu gimnasio, tendras ingresos adicionales cada vez que un usuario de GymGo entrene en tus instalaciones.',
                        textAlign: TextAlign.justify,
                      ),
                      SizedBox(
                        height: 32,
                      ),
                      SwitchListTile(
                        title: Text('¿Formarás parte?'),
                        onChanged: (s) {
                          gymRegModel.statePlan = !gymRegModel.getGym.statePlan;
                        },
                        value: gymRegModel.getGym.statePlan,
                      ),
                      AnimatedContainer(
                        duration: Duration(seconds: 1),
                        height: gymRegModel.getGym.statePlan ? 50 : 0,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text('Elige tu Plan'),
                            Container(
                              // margin: EdgeInsets.only(bottom: 32),

                              padding: EdgeInsets.only(right: 8, left: 8),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                border: Border.all(
                                    width: 0.5, color: Colors.black26),
                              ),
                              child: DropdownButtonHideUnderline(
                                child: DropdownButton(
                                  value: gymRegModel.getGym.plan,
                                  icon: Icon(
                                    Icons.keyboard_arrow_down,
                                    color: gymRegModel.getGym.statePlan
                                        ? Colors.black
                                        : Colors.transparent,
                                  ),
                                  iconSize: 24,
                                  elevation: 16,
                                  onChanged: (String newValue) {
                                    gymRegModel.plan = newValue;
                                  },
                                  items: <String>['Basic', 'Medium', 'Premium']
                                      .map((String value) {
                                    return DropdownMenuItem<String>(
                                      value: value,
                                      child: Text(value),
                                    );
                                  }).toList(),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        height: gymRegModel.getGym.statePlan ? 32 : 16,
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
                            onTap: () async {
                              if (_formKey.currentState.validate()) {
                                _formKey.currentState.save();
                                try {
                                  gymModel.addMyGym(
                                      await gymRegModel.addToGymCollection(
                                          userId: userModel.getUser().userId));
                                  Navigator.pop(context);
                                } catch (e) {
                                  print('Error' + e);
                                }
                              }
                            },
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                Icon(
                                  Icons.check,
                                  color: Colors.white,
                                ),
                                SizedBox(
                                  width: 8,
                                ),
                                Text(
                                  'Finalizar',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 14),
                                ),
                                SizedBox(
                                  width: 4,
                                ),
                              ],
                            ),
                          )
                        ],
                      )
                    ]))));
  }
}
