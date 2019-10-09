import 'package:flutter/material.dart';
import 'package:gym_go/colors.dart';
import 'package:gym_go/model/gym_reg_model.dart';
import 'package:gym_go/model/user.dart';
import 'package:gym_go/pages/gym_registration/detail.dart';
import 'package:gym_go/pages/gym_registration/direction.dart';
import 'package:gym_go/pages/gym_registration/general_data.dart';
import 'package:gym_go/pages/gym_registration/offer.dart';
import 'package:gym_go/widget/nav_bar_registrarion_gym.dart';
import 'package:provider/provider.dart';

class GymRegistration extends StatefulWidget {
  @override
  _GymRegistrationState createState() => _GymRegistrationState();
}

class _GymRegistrationState extends State<GymRegistration>
    with SingleTickerProviderStateMixin {
  TabController _tabController;

  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    UserModel userModel = Provider.of(context);
    return ChangeNotifierProvider(
      builder: (_) =>
          GymRegModel(vsync: this, userId: userModel.getUser().userId)
            ..location = userModel.getCurrentLocation(),
      child: Consumer<GymRegModel>(builder: (_, gymModel, child) {
        return Theme(
          data: Theme.of(context).copyWith(
              inputDecorationTheme: InputDecorationTheme(
            contentPadding: EdgeInsets.only(left: 15.0, top: 25.0),
            border: OutlineInputBorder(borderSide: BorderSide(width: 0.1)),
            focusedBorder: OutlineInputBorder(
                borderSide:
                    BorderSide(width: 1, color: ColorPalette.black959DAD)),
            focusColor: Colors.red,
            enabledBorder: OutlineInputBorder(
                borderSide:
                    BorderSide(width: 1, color: ColorPalette.blackEEEEEE)),
          )),
          child: DefaultTabController(
            length: 4,
            initialIndex: 0,
            child: Scaffold(
              appBar: AppBar(
                title: Text('Agregar Gimnasio'),
                bottom: PreferredSize(
                  preferredSize: const Size.fromHeight(48.0),
                  child: NavBarRegistrationGym(
                    colorsContentItem: Colors.white,
                    colorsItem: Colors.blue,
                    selectedIndex: gymModel.selectIndex,
                    showElevation:
                        false, // use this to remove appBar's elevation

                    items: [
                      BottomNavyBarItem(
                        title: Text('General'),
                      ),
                      BottomNavyBarItem(
                        title: Text('Dirección'),
                      ),
                      BottomNavyBarItem(
                        title: Text('¿Qué ofrece?'),
                      ),
                      BottomNavyBarItem(
                        title: Text('Detalles'),
                      ),
                    ],
                  ),
                ),
              ),
              body: TabBarView(
                controller: gymModel.getTabController,
                physics: NeverScrollableScrollPhysics(),
                children: <Widget>[
                  GeneralData(),
                  Direction(),
                  Offer(),
                  Detail()
                ],
              ),
            ),
          ),
        );
      }),
    );
  }
}

class BottomAppBar extends StatefulWidget {
  @override
  _BottomAppBarState createState() => _BottomAppBarState();
}

class _BottomAppBarState extends State<BottomAppBar> {
  int selectedIndex = 0;
  Color backgroundColor = Colors.white;

  Widget _buildItem(NavigationItem item, bool isSelected) {
    return Expanded(
      flex: isSelected ? 1 : 0,
      child: AnimatedContainer(
        duration: Duration(milliseconds: 270),
        width: isSelected ? 120 : 50,
        height: double.maxFinite,
        padding: isSelected ? EdgeInsets.only(left: 16, right: 16) : null,
        decoration: isSelected
            ? BoxDecoration(
                color: item.color,
                borderRadius: BorderRadius.all(Radius.circular(50)))
            : null,
        child: ListView(
          scrollDirection: Axis.horizontal,
          children: <Widget>[
            Row(
              children: <Widget>[
                IconTheme(
                  data: IconThemeData(
                      size: 24,
                      color: isSelected ? backgroundColor : Colors.black),
                  child: item.icon,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: isSelected
                      ? DefaultTextStyle.merge(
                          style: TextStyle(color: backgroundColor),
                          child: item.title)
                      : Container(),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    List<NavigationItem> items = [
      NavigationItem(
          icon: Icon(Icons.home),
          title: Text('Home'),
          color: Colors.purpleAccent),
      NavigationItem(
          icon: Icon(Icons.favorite),
          title: Text('Favorite'),
          color: Colors.pinkAccent),
      NavigationItem(
          icon: Icon(Icons.search), title: Text('Search'), color: Colors.amber),
      NavigationItem(
          icon: Icon(Icons.person), title: Text('Profile'), color: Colors.cyan),
    ];
    final size = MediaQuery.of(context).size;
    return Container(
      width: size.width,
      height: 48,
      padding: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
      decoration: BoxDecoration(
          color: backgroundColor,
          boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 4)]),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: items.map((item) {
          var itemIndex = items.indexOf(item);

          return _buildItem(item, selectedIndex == itemIndex);
        }).toList(),
      ),
    );
  }
}

class NavigationItem {
  final Icon icon;
  final Text title;
  final Color color;
  NavigationItem({this.color, this.icon, this.title});
}
