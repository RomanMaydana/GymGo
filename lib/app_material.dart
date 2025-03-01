import 'package:flutter/material.dart';
import 'package:gym_go/class/detail_gym_page_arguments.dart';
import 'package:gym_go/class/gym_registration.dart';
import 'package:gym_go/class/message_check_in_args.dart';
import 'package:gym_go/model/gym_model.dart';
import 'package:gym_go/model/plan_model.dart';
import 'package:gym_go/model/push_notification_provider.dart';
import 'package:gym_go/model/suscription_model.dart';
import 'package:gym_go/model/user.dart';
import 'package:gym_go/pages/check_in/list_of_check_in.dart';
import 'package:gym_go/pages/detail_gym/detail_gym_page.dart';
import 'package:gym_go/pages/gym_registration/gym_registration.dart';
import 'package:gym_go/pages/gym_registration/pin_in_map.dart';
import 'package:gym_go/pages/messages/message_check_in.dart';
import 'package:gym_go/pages/messages/message_suscription.dart';
import 'package:gym_go/pages/my_gyms_page.dart';
import 'package:gym_go/pages/profile_page.dart';
import 'package:gym_go/pages/shopping/shopping.dart';
import 'package:gym_go/pages/sign_in.dart';
import 'package:gym_go/pages/sign_up.dart';
import './pages/tab_bar_page.dart';
import './pages/root.dart';
import './pages/splash_sreen.dart';
import 'package:provider/provider.dart';

import 'class/my_check_in_argument.dart';
import 'class/shopping_page.dart';

class AppMaterialGym extends StatefulWidget {
  @override
  _AppMaterialGymState createState() => _AppMaterialGymState();
}

class _AppMaterialGymState extends State<AppMaterialGym> {
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
  @override
  void initState() {
    final pushProvider = PushNotificationProvider();
    pushProvider.initNotificacion();
    pushProvider.mensajes.listen((data) {
      print('Argumentos del push');
      print(data);
      switch (data['type']) {
        case 'checkIn':
          final MessageCheckInArgs messageCheckInArgs = MessageCheckInArgs(
              id: data['id'], picture: data['piture'] ?? null);
          navigatorKey.currentState
              .pushNamed('/mensajecheckin', arguments: messageCheckInArgs);
          break;
        case 'gymsucces':
          navigatorKey.currentState.pushNamed('/mygyms');
          break;
        case 'subscription':
          navigatorKey.currentState.push(MaterialPageRoute(
              builder: (context) => MessageSuscription(
                    id: data['id'],
                  )));
          break;
        default:
          break;
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          builder: (context) => UserModel(),
        ),
        ChangeNotifierProvider(
          builder: (context) => GymModel(),
        ),
        ChangeNotifierProvider(
          builder: (context) => PlanModel(),
        ),
        ChangeNotifierProvider(
          builder: (context) => SubscriptionModel(),
        ),
      ],
      child: MaterialApp(
        navigatorKey: navigatorKey,
        onGenerateRoute: _getRoute,
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
            scaffoldBackgroundColor: Colors.white,
            appBarTheme: AppBarTheme(
                actionsIconTheme: IconThemeData(color: Color(0xFF0E1D4A)),
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
      case '/mensajecheckin':
        final MessageCheckInArgs args = settings.arguments;
        return MaterialPageRoute(
            builder: (context) => MessageCheckIn(
                  id: args.id,
                  picture: args.picture,
                ));
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
        final GymRegistrationArguments args = settings.arguments;
        return MaterialPageRoute(
            builder: (context) => GymRegistration(
                  gym: args.gym,
                ));
        break;
      case '/shopping':
        final ShoppingPageArguments args = settings.arguments;
        return MaterialPageRoute(
            builder: (context) => ShoppingPage(
                  gym: args.gym,
                  plan: args.plan,
                ));
        break;
      case '/checkin':
        final ShoppingPageArguments args = settings.arguments;
        return MaterialPageRoute(
            builder: (context) => ShoppingPage(
                  gym: args.gym,
                  plan: args.plan,
                ));
        break;
      case '/mycheckin':
        final MyCheckInArgument args = settings.arguments;
        return MaterialPageRoute(
            builder: (context) => ListOfCheckIn(
                  userId: args.userId,
                ));
        break;
      case '/detailgym':
        final DetailGymPageArguments args = settings.arguments;
        return MaterialPageRoute(
            builder: (context) => DetailGymPage(
                  gym: args.gym,
                  subs: args.subs,
                ));
        break;
      case '/pininmap':
        return MaterialPageRoute(builder: (context) => PinInMap());
        break;
    }
  }
}
