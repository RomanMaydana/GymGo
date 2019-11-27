import 'package:flutter/material.dart';

class CircleColorDecorator extends StatelessWidget {
  final Color color;
  final double size;

  const CircleColorDecorator(
      {Key key, @required this.color, @required this.size})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: size,
      width: size,
      decoration:
          BoxDecoration(borderRadius: BorderRadius.circular(50), color: color),
    );
  }
}
