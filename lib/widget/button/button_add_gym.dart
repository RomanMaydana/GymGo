import 'package:flutter/material.dart';
import 'package:gym_go/colors.dart';

class ButtonAddGym extends StatelessWidget {
  final VoidCallback onPressed;
  final Color color;
  final double size;
  const ButtonAddGym({Key key, @required this.onPressed, this.color,@required this.size}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      borderRadius: BorderRadius.circular(5),
      child: InkWell(
        focusColor: Colors.transparent,
        highlightColor: Colors.transparent,
        borderRadius: BorderRadius.circular(5),
        onTap: onPressed,
        splashColor: color?? Theme.of(context).accentColor,
        child: Container(
          height: size,
          width: size,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(5)),
            border: Border.all(width: 1, color: ColorPalette.blackEEEEEE),
          ),
          child: Icon(
            Icons.add,
            size: (size*3/5),
          ),
        ),
      ),
    );
  }
}
