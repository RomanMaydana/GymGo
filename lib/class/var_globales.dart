import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

abstract class VarGlobales {
  static const iconService = {
    'Wifi': Icons.wifi,
    'Parqueo': Icons.local_parking,
    'Ducha': MdiIcons.showerHead,
    'Baño': MdiIcons.paperRollOutline,
    'Restaurant': MdiIcons.food,
    'Vestidor': MdiIcons.hanger,
    'Acceso para Discapacitados': MdiIcons.wheelchairAccessibility,
    'Taquilla': MdiIcons.wardrobeOutline,
    'Aire Acondicionado': MdiIcons.airConditioner,
    'Sauna': MdiIcons.hotTub
  };

  static const day = [
    'lunes',
    'martes',
    'miercoles',
    'jueves',
    'viernes',
    'sabado',
    'domingo'
  ];

  static const mapKey =
      'pk.eyJ1Ijoicm9tYW4yODc0NSIsImEiOiJjam1nb20xZGoyNGJiM3BxNHFiNmFhbmYzIn0.V4L0zVqTDPywBotviWlK7w';
}
