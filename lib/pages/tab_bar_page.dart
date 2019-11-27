import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:gym_go/model/suscription_model.dart';
import 'package:gym_go/model/user.dart';
import 'package:gym_go/pages/tabs/home.dart';
import 'package:gym_go/pages/tabs/memberships.dart';

import 'package:gym_go/pages/tabs/menu.dart';
import 'package:gym_go/pages/tabs/my_suscription.dart';
import 'package:provider/provider.dart';

class TabBarPage extends StatefulWidget {
  @override
  _TabBarPageState createState() => _TabBarPageState();
}

class _TabBarPageState extends State<TabBarPage>
    with SingleTickerProviderStateMixin {
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  TabController _tabController;
  int _selectedIndex = 0;
  bool _indexHome = true;
  @override
  void initState() {
    _tabController = TabController(initialIndex: 0, length: 4, vsync: this);
    // _tabController.addListener(() {
    //   print(_tabController.index);
    //   if (_tabController.index == 0) {
    //     setState(() {
    //       _indexHome = true;
    //     });
    //   } else
    //     setState(() {
    //       _indexHome = false;
    //     });
    // });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    UserModel userModel = Provider.of(context);
    SubscriptionModel subscriptionModel = Provider.of(context);
    userModel.registrationTacontroller(controller: _tabController);
    subscriptionModel.getSubscriptionWhenVerify(userModel.getUser().userId);
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        backgroundColor: Colors.white,
        // appBar: PreferredSize(
        //   preferredSize:
        //       _indexHome ? Size.fromHeight(48) : Size.fromHeight(0.0),
        //   child: AppBar(
        //     centerTitle: true,
        //     title: Text('GymGo'),
        //     actions: <Widget>[
        //       IconButton(
        //         onPressed: () {},
        //         icon: Icon(
        //           Icons.tune,
        //         ),
        //       )
        //     ],
        //   ),
        // ),
        body: TabBarView(
          
          controller: userModel.getTabController(),
          children: <Widget>[
            HomeTab(),
            MySubscriptionTab(),
            Memberships(),
            MenuTab(),
          ],
        ),
        // bottomNavigationBar: BottomNavyBar(

        //   selectedIndex: userModel.getTabController().index,
        //   showElevation: true, // use this to remove appBar's elevation
        //   onItemSelected: (index) => userModel.toIndexInTabView(index),
        //   items: [
        //     BottomNavyBarItem(
        //       icon: Icon(Icons.home),
        //       title: Text('Home'),
        //       activeColor: Colors.red,
        //     ),
        //     BottomNavyBarItem(
        //         icon: Icon(Icons.playlist_add_check),
        //         title: Text('Check-In'),
        //         activeColor: Colors.purpleAccent),
        //     BottomNavyBarItem(
        //         icon: Icon(Icons.subscriptions),
        //         title: Text('Planes'),
        //         activeColor: Colors.pink),
        //     BottomNavyBarItem(
        //         icon: Icon(Icons.menu),
        //         title: Text('Menú'),
        //         activeColor: Colors.blue),
        //   ],
        // ),
        bottomNavigationBar: Container(
          decoration: BoxDecoration(
              boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 15)],
              color: Colors.white,
              borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
          child: TabBar(
            controller: userModel.getTabController(),
            labelColor: Theme.of(context).accentColor,
            unselectedLabelColor: Theme.of(context).primaryColor,
            indicatorSize: TabBarIndicatorSize.tab,
            dragStartBehavior: DragStartBehavior.start,
            tabs: <Widget>[
              Tab(
                icon: Icon(Icons.home),
              ),
              Tab(
                icon: Icon(Icons.playlist_add_check),
              ),
              Tab(
                icon: Icon(Icons.subscriptions),
              ),
              Tab(
                icon: Icon(Icons.menu),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
