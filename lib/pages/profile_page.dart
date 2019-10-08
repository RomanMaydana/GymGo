import 'package:flutter/material.dart';
import 'package:gym_go/colors.dart';
import 'package:gym_go/model/user.dart';
import 'package:gym_go/style/linear.dart';
import 'package:gym_go/style/text.dart';
import 'package:gym_go/widget/circle_decorator.dart';
import 'package:provider/provider.dart';

final linearBlack = Container(
  margin: EdgeInsets.only(top: 16, bottom: 32),
  height: 0.9,
  width: double.infinity,
  color: Colors.black12,
);

class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    UserModel userModel = Provider.of(context);
    return  Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text('Perfil'),
          actions: <Widget>[
            Container(
              child: IconButton(
                onPressed: () {},
                color: Colors.orange,
                icon: Icon(Icons.edit),
              ),
            ),
            Container(
              child: IconButton(
                onPressed: () {
                  userModel.signOut();
                },
                color: Colors.red,
                icon: Icon(Icons.exit_to_app),
              ),
            ),
          ],
        ),
        body: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.all(32),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  height: 140,
                  width: 140,
                  child: Stack(
                    children: <Widget>[
                      Hero(
                        tag: 'profile',
                        child: Container(
                          height: 140,
                          width: 140,
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              boxShadow: [
                                BoxShadow(
                                  blurRadius: 20,
                                  color: Colors.black12,
                                  offset: Offset(5, 5),
                                  spreadRadius: 2,
                                )
                              ],
                              image: DecorationImage(
                                  image: NetworkImage(
                                      'https://image.freepik.com/vector-gratis/perfil-avatar-hombre-icono-redondo_24640-14044.jpg'))),
                        ),
                      ),
                      Align(
                        alignment: Alignment.bottomRight,
                        child: CircleAvatar(
                          backgroundColor: Theme.of(context).accentColor,
                          child: IconButton(
                            onPressed: () {},
                            icon: Icon(
                              Icons.camera_alt,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 32,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      'Nombre',
                      style: StylesText.textLightBlack26md,
                    ),
                    Text(
                      userModel.getUser().fullName,
                      style: StylesText.textblackmd,
                    )
                  ],
                ),
                linearBlack,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      'Correo',
                      style: StylesText.textLightBlack26md,
                    ),
                    Text(
                      userModel.getUser().email,
                      style: StylesText.textblackmd,
                    )
                  ],
                ),
                linearBlack,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      'Cedula de Identidad',
                      style: StylesText.textLightBlack26md,
                    ),
                    Text(
                      userModel.getUser().ci ?? 'Sin registrar',
                      style: StylesText.textblackmd,
                    )
                  ],
                ),
                linearBlack,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      'Celular',
                      style: StylesText.textLightBlack26md,
                    ),
                    Text(
                      userModel.getUser().celular ?? 'Sin registrar',
                      style: StylesText.textblackmd,
                    )
                  ],
                ),
                linearBlack,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      'Fecha de Nacimiento',
                      style: StylesText.textLightBlack26md,
                    ),
                    Text(
                      userModel.getUser().birthDate == null
                          ? 'Sin registrar'
                          : userModel.getUser().birthDateExact,
                      style: StylesText.textblackmd,
                    )
                  ],
                ),
                linearBlack,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      'Sexo',
                      style: StylesText.textLightBlack26md,
                    ),
                    Text(
                      userModel.getUser().sexo == null
                          ? 'Sin registrar'
                          : userModel.getUser().birthDateExact,
                      style: StylesText.textblackmd,
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      
    );
  }
}
