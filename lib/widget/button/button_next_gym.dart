import 'package:flutter/material.dart';

class ButtonNextGym extends StatelessWidget {
  final Widget child;
  final VoidCallback onTap;
  final double radius;
  final Color color;
  final Color splashColor;
  
  const ButtonNextGym(
      {Key key,
      @required this.child,
      @required this.onTap,
      this.radius = 0,
      this.color,
      this.splashColor,
      })
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(boxShadow: [
        BoxShadow(
            blurRadius: 6,
            color: Colors.black12,
            spreadRadius: 2,
            offset: Offset(0, 4)),
      ], borderRadius: BorderRadius.circular(radius)),
      child: Material(
        // elevation: elevation,
        borderRadius: BorderRadius.circular(radius),
      
        color: color ?? Theme.of(context).accentColor,
        child: InkWell(
          onTap: onTap,
          splashColor: splashColor ?? Theme.of(context).accentColor,
          highlightColor: Colors.transparent,
          borderRadius: BorderRadius.circular(radius),
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 15, horizontal: 15),
            child: child,
          ),
        ),
      ),
    );
  }
}
