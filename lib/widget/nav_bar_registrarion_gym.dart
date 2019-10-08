import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class NavBarRegistrationGym extends StatelessWidget {
  final int selectedIndex;
  final double iconSize;
  final Color backgroundColor;
  final Color colorsItem;
  final Color colorsContentItem;
  final bool showElevation;
  final Duration animationDuration;
  final List<BottomNavyBarItem> items;
  final ValueChanged<int> onItemSelected;

  NavBarRegistrationGym(
      {Key key,
      this.selectedIndex = 0,
      this.showElevation = true,
      this.iconSize = 24,
      this.backgroundColor,
      this.animationDuration = const Duration(milliseconds: 270),
      @required this.items,
      this.onItemSelected,
      @required this.colorsItem,
      @required this.colorsContentItem}) {
    assert(items != null);
    assert(items.length >= 2 && items.length <= 5);
  }

  Widget _buildItem(BottomNavyBarItem item, bool isSelected, int index) {
    return Expanded(
      flex: isSelected ? 1 : 0,
      child: AnimatedContainer(
        width: isSelected ? 130 : 50,
        height: double.maxFinite,
        duration: animationDuration,
        padding: EdgeInsets.only(left: 12),
        child: ListView(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          scrollDirection: Axis.horizontal,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: Container(
                    alignment: Alignment.center,
                    height: 25,
                    width: 25,
                    decoration: BoxDecoration(
                      color: selectedIndex >= index
                          ? colorsItem
                          : colorsContentItem,
                      boxShadow: index > selectedIndex
                          ? [
                              BoxShadow(
                                  blurRadius: 3,
                                  color: Colors.black12,
                                  offset: Offset(0, 2.5))
                            ]
                          : null,
                      borderRadius: BorderRadius.all(Radius.circular(50)),
                    ),
                    child: index >= selectedIndex
                        ? Text(
                            '${index + 1}',
                            style: TextStyle(
                                color: selectedIndex == index
                                    ? colorsContentItem
                                    : Colors.black26,
                                fontSize: 18,
                                fontWeight: FontWeight.w500),
                          )
                        : Icon(
                            Icons.check,
                            color: colorsContentItem,
                            size: 20,
                          ),
                  ),
                ),
                isSelected
                    ? DefaultTextStyle.merge(
                        style: TextStyle(
                            fontWeight: FontWeight.w600, fontSize: 18),
                        child: item.title,
                      )
                    : SizedBox.shrink()
              ],
            )
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final bgColor = (backgroundColor == null)
        ? Theme.of(context).bottomAppBarColor
        : backgroundColor;

    return Column(
      children: <Widget>[
        Container(
          decoration: BoxDecoration(color: bgColor, boxShadow: [
            if (showElevation) BoxShadow(color: Colors.black12, blurRadius: 2)
          ]),
          child: SafeArea(
            child: Container(
              width: double.infinity,
              height: 56,
              padding: EdgeInsets.only(left: 8, right: 8, top: 6, bottom: 6),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: items.map((item) {
                  var index = items.indexOf(item);
                  return _buildItem(item, selectedIndex == index, index);
                }).toList(),
              ),
            ),
          ),
        ),
        Theme(
          data: Theme.of(context).copyWith(accentColor: colorsItem),
          child: Container(
            height: 3,
            child: LinearProgressIndicator(
              backgroundColor: Colors.white,
              value: 1 * (selectedIndex + 1) / (items.length),
            ),
          ),
        )
      ],
    );
  }
}

class BottomNavyBarItem {
  final Text title;

  BottomNavyBarItem({
    @required this.title,
  }) {
    assert(title != null);
  }
}
