import 'package:flutter/material.dart';
import 'package:gym_go/class/detail_gym_page_arguments.dart';
import 'package:gym_go/model/gym_model.dart';
import 'package:gym_go/model/user.dart';
import 'package:gym_go/pages/detail_gym/detail_gym_page.dart';
import 'package:gym_go/pages/gym_registration/gym_registration.dart';
import 'package:gym_go/pages/gym_registration/pin_in_map.dart';
import 'package:gym_go/pages/my_gyms_page.dart';
import 'package:gym_go/pages/profile_page.dart';
import 'package:gym_go/pages/sign_in.dart';
import 'package:gym_go/pages/sign_up.dart';
import './pages/tab_bar_page.dart';
import './pages/root.dart';
import './pages/splash_sreen.dart';
import 'package:provider/provider.dart';

class AppMaterialGym extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          builder: (context) => UserModel(),
        ),
        ChangeNotifierProvider(
          builder: (context) => GymModel(),
        )
      ],
      child: MaterialApp(
        onGenerateRoute: _getRoute,
        theme: ThemeData(
            scaffoldBackgroundColor: Colors.white,
            appBarTheme: AppBarTheme(
              actionsIconTheme: IconThemeData(
                color: Color(0xFF0E1D4A)
              ),
                elevation: 0,
                color: Colors.white,
                textTheme: TextTheme(
                    title: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.w500)),
                iconTheme: IconThemeData(color: Colors.black)),
            fontFamily: 'Raleway',
            primaryColor: Color(0xFF0E1D4A),
            accentColor: Color(0xFFF9721F),
            dialogTheme: DialogTheme(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5)),
            ),
            inputDecorationTheme: InputDecorationTheme(
                enabledBorder:
                    UnderlineInputBorder(borderSide: BorderSide(width: 0.3)))),
      ),
    );
  }

  Route _getRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (context) => SplashScreen());
        break;
      case '/home':
        return MaterialPageRoute(builder: (context) => TabBarPage());
        break;
      case '/root':
        return MaterialPageRoute(builder: (context) => RootPage());
        break;
      case '/signIn':
        return MaterialPageRoute(builder: (context) => SignInPage());
        break;
      case '/signUp':
        return MaterialPageRoute(builder: (context) => SignUpPage());
        break;
      case '/profile':
        return MaterialPageRoute(builder: (context) => ProfilePage());
        break;
      case '/mygyms':
        return MaterialPageRoute(builder: (context) => MyGymsPage());
        break;
      case '/gymregistration':
        return MaterialPageRoute(builder: (context) => GymRegistration());
        break;
      case '/detailgym':
        final DetailGymPageArguments args = settings.arguments;
        return MaterialPageRoute(
            builder: (context) => DetailGymPage(
                  gym: args.gym,
                ));
        break;
      case '/pininmap':
        return MaterialPageRoute(builder: (context) => PinInMap());
        break;
    }
  }
}
