import 'package:flutter/material.dart';
import 'package:gym_go/model/gym_model.dart';
import 'package:gym_go/model/user.dart';
import 'package:gym_go/style/text.dart';
import 'package:provider/provider.dart';

class MenuTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    UserModel userModel = Provider.of(context);
    GymModel gymModel = Provider.of(context);
    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Container(
                  child: IconButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/profile');
                    },
                    color: Colors.orange,
                    icon: Icon(Icons.person_outline),
                  ),
                ),
                SizedBox(
                  width: 16,
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
            SizedBox(
              height: 16,
            ),
            InkWell(
              borderRadius: BorderRadius.circular(50),
              onTap: () {
                Navigator.pushNamed(context, '/profile');
              },
              child: Hero(
                tag: 'profile',
                child: Container(
                  height: 100,
                  width: 100,
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
            ),
            SizedBox(
              height: 8,
            ),
            Text(
              '${userModel.getUser().fullName}',
              style: StylesText.textblackmd,
            ),
            SizedBox(
              height: 16,
            ),
            ListTile(
              onTap: () {
                // gymModel.getCollectionMyGym(userId: userModel.getUser().userId);
                Navigator.pushNamed(context, '/mygyms');
              },
              leading: CircleAvatar(
                child: Icon(Icons.fitness_center),
              ),
              title: Text('Mis Gimnasios'),
            ),
            ListTile(
              onTap: () {
                userModel.toIndexInTabView(1);
              },
              leading: CircleAvatar(
                backgroundColor: Colors.green,
                child: Icon(
                  Icons.playlist_add_check,
                  color: Colors.white,
                ),
              ),
              title: Text('Mis Suscripciones'),
            )
          ],
        ),
      ),
    );
  }
}
