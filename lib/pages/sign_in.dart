import 'package:flutter/material.dart';
import 'package:gym_go/colors.dart';
import 'package:gym_go/model/user.dart';
import 'package:gym_go/style/text.dart';
import 'package:gym_go/widget/clipper/deformed_shape_black.dart';
import 'package:provider/provider.dart';
import '../widget/clipper/deformed_shape_orange.dart';
import '../widget/clipper/deformed_shape_orange.dart';

class SignInPage extends StatefulWidget {
  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final _formKey = GlobalKey<FormState>();
  String _email;
  String _password;
  bool _isAdded = false;
  @override
  Widget build(BuildContext context) {
    UserModel userModel = Provider.of(context);
    return Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Column(children: [
            Stack(children: <Widget>[
              Positioned(
                top: 20,
                right: -130,
                child: CircleAvatar(
                  radius: 150,
                  backgroundColor: ColorPalette.lightBlue,
                ),
              ),
              ClipPath(
                clipper: DeformedShapeBlack(),
                child: Container(
                  height: 350,
                  width: double.infinity,
                  color: Theme.of(context).primaryColor,
                ),
              ),
              ClipPath(
                clipper: DeformedShapeOrange(),
                child: Container(
                    height: 150,
                    width: 300,
                    color: Theme.of(context).accentColor),
              ),
              Positioned(
                top: 150,
                child: Padding(
                  padding: const EdgeInsets.only(left: 32),
                  child: Container(
                    child: Text(
                      'Bienvenido',
                      style: StylesText.loginTitle,
                    ),
                  ),
                ),
              )
            ]),
            Form(
              key: _formKey,
              child: Column(
                children: <Widget>[
                  Container(
                    margin: const EdgeInsets.all(32.0),
                    child: Column(children: [
                      TextFormField(
                        decoration: InputDecoration(hintText: 'Correo'),
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Por favor ingrese su correo.';
                          }
                          return null;
                        },
                        onSaved: (email) => _email = email,
                      ),
                      SizedBox(
                        height: 32,
                      ),
                      TextFormField(
                        decoration: InputDecoration(hintText: 'Contraseña'),
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Por favor ingrese su contraseña';
                          }
                          return null;
                        },
                        onSaved: (password) => _password = password,
                      ),
                      SizedBox(
                        height: 32,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(
                            'Iniciar sesión',
                            style: StylesText.loginIntoPrimaryColor,
                          ),
                          Stack(
                            children: <Widget>[
                              Align(
                                alignment: Alignment.center,
                                child: AnimatedOpacity(
                                  duration: Duration(milliseconds: 600),
                                  curve: Curves.easeIn,
                                  opacity: _isAdded ? 0.0 : 1.0,
                                  child: IconButton(
                                    iconSize: 60,
                                    onPressed: () {
                                      
                                      if (_formKey.currentState.validate()) {
                                        _formKey.currentState.save();
                                        setState(() {
                                        _isAdded = !_isAdded;
                                      });
                                        try {
                                          userModel.signIn(_email, _password);
                                          // userModel.changedAuthLoggedIn();
                                        } catch (e) {}
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
                                  ),
                                ),
                              ),
                              Align(
                                alignment: Alignment.bottomCenter,
                                child: AnimatedOpacity(
                                  duration: Duration(milliseconds: 550),
                                  opacity: _isAdded ? 1.0 : 0.0,
                                  child: CircularProgressIndicator(
                                    
                                  ),
                                ),
                              )
                            ],
                          )
                        ],
                      ),
                      SizedBox(
                        height: 32,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          InkWell(
                            onTap: () {
                              userModel.changedAuthSignUp();
                            },
                            child: Container(
                              child: Text(
                                'Regístrate',
                                style: StylesText.loginChange(
                                    color: Theme.of(context).primaryColor),
                              ),
                            ),
                          ),
                          Text('¿Olvidaste tu contraseña?')
                        ],
                      )
                    ]),
                  ),
                ],
              ),
            ),
          ]),
        ));
  }
}
