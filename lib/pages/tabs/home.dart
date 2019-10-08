import 'package:flutter/material.dart';
import 'package:gym_go/pages/availible_gyms_in_list.dart';

class HomeTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: AvailibleGymsInList(),
    );
  }
}