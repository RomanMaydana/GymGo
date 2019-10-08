import 'package:flutter/material.dart';
import 'package:gym_go/colors.dart';
import 'package:gym_go/model/user.dart';
import 'package:gym_go/style/text.dart';
import 'package:gym_go/widget/clipper/deformed_shape_black.dart';
import 'package:gym_go/widget/clipper/deformed_shape_black_media.dart';
import 'package:gym_go/widget/clipper/deformed_shape_light_blue.dart';
import 'package:provider/provider.dart';
import '../widget/clipper/deformed_shape_orange.dart';
import '../widget/clipper/deformed_shape_orange.dart';

class SignUpPage extends StatefulWidget {
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _formKey = GlobalKey<FormState>();
  
  String _name;
  String _email;
  String _password;

  @override
  Widget build(BuildContext context) {
    final media = MediaQuery.of(context);
    UserModel userModel = Provider.of(context);
    return Scaffold(
        backgroundColor: Colors.white,
        body: Theme(
          data: Theme.of(context).copyWith(
              inputDecorationTheme: InputDecorationTheme(
                  hintStyle: TextStyle(color: Colors.white),
                  enabledBorder: UnderlineInputBorder(
                      borderSide:
                          BorderSide(color: Colors.white, width: 0.3)))),
          child: SingleChildScrollView(
              child: Form(
                key: _formKey,
            child: Stack(
              children: <Widget>[
                ClipPath(
                  clipper: DeformedShapeLightBlue(),
                  child: Container(
                    height: media.size.height,
                    width: media.size.width,
                    color: ColorPalette.lightBlue,
                  ),
                ),
                ClipPath(
                  clipper: DeformedShapeBlackMedia(),
                  child: Container(
                    height: media.size.height / 2,
                    width: media.size.width,
                    color: Theme.of(context).primaryColor,
                  ),
                ),
                Positioned(
                  bottom: 0,
                  child: SizedBox(
                    width: media.size.width,
                    child: Padding(
                      padding: const EdgeInsets.all(32.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            'Crea una\nCuenta',
                            style: StylesText.loginTitle,
                          ),
                          SizedBox(
                            height: 60,
                          ),
                          TextFormField(
                            decoration: InputDecoration(
                                hintText: 'Nombre',
                                hintStyle: StylesText.hintStyleWhite,
                                fillColor: Colors.white),
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'Por favor ingrese su nombre.';
                              }
                              return null;
                            },
                            onSaved: (name)=>_name = name,
                          ),
                          SizedBox(
                            height: 32,
                          ),
                          TextFormField(
                            decoration: InputDecoration(hintText: 'Correo'),
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'Por favor ingrese un correo.';
                              }
                              return null;
                            },
                            onSaved: (email)=> _email = email,
                          ),
                          SizedBox(
                            height: 32,
                          ),
                          TextFormField(
                            decoration: InputDecoration(hintText: 'Contraseña'),
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'Por favor ingrese una contraseña.';
                              }
                              return null;
                            },
                            onSaved: (password)=> _password = password,
                          ),
                          SizedBox(
                            height: 60,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text(
                                'Registrar',
                                style: StylesText.loginIntoWhite,
                              ),
                               IconButton(
                                iconSize: 60,
                                onPressed: () {
                                  if(_formKey.currentState.validate()){
                                    _formKey.currentState.save();

                                    userModel.signUp(_email,_password, _name);
                                  }
                                },
                                icon: CircleAvatar(
                                  radius: 30,
                                  backgroundColor:
                                      Theme.of(context).primaryColor,
                                  child: Icon(
                                    Icons.chevron_right,
                                    color: Colors.white,
                                  ),
                                ),
                              )
                            ],
                          ),
                          SizedBox(
                            height: 32,
                          ),
                          InkWell(
                            onTap: () {
                              userModel.changedAuthSignIn();
                            },
                            child: Container(
                              alignment: Alignment.topLeft,
                              child: Text(
                                'Iniciar Sesion',
                                style:
                                    StylesText.loginChange(color: Colors.white),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          )),
        ));
  }
}
