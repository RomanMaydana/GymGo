import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import './app_material.dart';

void main() {
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  runApp(AppMaterialGym());
}
