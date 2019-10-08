import 'package:flutter/material.dart';

class Stars extends StatelessWidget {
  final double rating;
  final Color color;
  final double sizeIcon;
  const Stars(
      {Key key,
      @required this.rating,
      @required this.color,
      @required this.sizeIcon})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    bool may = (rating - rating.toInt()) > 0;
    return Row(
      children: <Widget>[
        for (var i = 0; i < rating.toInt(); i++)
          Icon(
            Icons.star,
            color: color,
            size: sizeIcon,
          ),
        if (may) Icon(Icons.star_half, size: sizeIcon, color: Colors.yellow),
        for (var i = rating.toInt(); i < 5; i++)
          Icon(
            Icons.star,
            color: Colors.black12,
            size: sizeIcon,
          ),
      ],
    );
  }
}
