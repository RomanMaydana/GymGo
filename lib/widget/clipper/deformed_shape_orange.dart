import 'package:flutter/cupertino.dart';

class DeformedShapeOrange  extends CustomClipper<Path>{
  @override
  getClip(Size size) {
    var path = Path();
    path.lineTo(0, size.height);
    path.quadraticBezierTo(size.width/6, size.height,size.width/4, size.height - 60);
    path.quadraticBezierTo(size.width/2, 10,size.width, 0);
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper oldClipper) => false;

}