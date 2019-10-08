import 'package:flutter/rendering.dart';

class DeformedShapeBlackMedia extends CustomClipper<Path>{
  @override
  Path getClip(Size size) {
    var path = Path();
    path.lineTo(0, size.height);
    path.quadraticBezierTo(size.width/4, size.height-60, size.width/2, size.height-50);
    path.quadraticBezierTo(size.width*3/4, size.height-30, size.width, size.height-100);
    path.lineTo(size.width, 0);
    path.close();
    return path;
    
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper)=> false;

}