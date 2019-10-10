import 'package:flutter/material.dart';

class PlanStyle {
  Map stylePlan(String type) {
    switch (type) {
      case 'Premium':
        return {
          'color': Color(0xffeb963c),
          'direction': 'images/premium.svg',
        };
        break;
      case 'Medium':
        return {
          'color': Color(0xffe22534),
          'direction': 'images/medium.svg',
        };
        break;
      case 'Basic':
        return {
          'color': Color(0xff429ed1),
          'direction': 'images/basic.svg',
        };
        break;
      default:
        return {
          'color': Colors.orange,
          'direction': 'images/premium.svg',
        };
        break;
    }
  }
}
