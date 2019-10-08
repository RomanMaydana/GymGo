import 'package:flutter/rendering.dart';

class DeformedShapeLightBlue extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.lineTo(0, size.height);
    path.lineTo(size.width / 2, size.height);
    path.quadraticBezierTo(size.width-size.width/3, size.height-200, size.width, size.height*3/4);
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
