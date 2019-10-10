import 'package:flutter/material.dart';
import 'package:gym_go/model/suscription_model.dart';
import 'package:gym_go/pages/tab_bar_page.dart';
import 'package:gym_go/pages/sign_in.dart';
import 'package:gym_go/pages/sign_up.dart';
import 'package:provider/provider.dart';

// Model
import '../model/user.dart';

class RootPage extends StatefulWidget {
  @override
  _RootPageState createState() => _RootPageState();
}

class _RootPageState extends State<RootPage> {
  
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    UserModel userModel = Provider.of(context);
    
    switch(userModel.statusAuth){
      case AuthStatus.logged_in:
        return TabBarPage();
        break;
      case AuthStatus.sign_in:
        return SignInPage();
        break;
      case AuthStatus.sign_up:
        return SignUpPage();
        break;
      default:
        return Scaffold(
          body: CircularProgressIndicator(),
        );
    }
    
  }
}


