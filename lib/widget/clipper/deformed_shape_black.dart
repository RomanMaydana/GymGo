
import 'package:flutter/rendering.dart';

class DeformedShapeBlack extends CustomClipper<Path>{
  
  @override
  Path getClip(Size size) {
    var path = Path();
    path.lineTo(0, size.height-100);
    path.quadraticBezierTo(size.width*0.8/2, size.height, size.width*3/5,  size.height-130);
    path.quadraticBezierTo(size.width*2/3, size.height/3, size.width-75,  75);
    path.quadraticBezierTo(size.width-25, 50,size.width , 25);
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;

}