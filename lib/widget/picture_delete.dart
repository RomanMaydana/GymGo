import 'package:flutter/material.dart';

class PictureDelete extends StatelessWidget {
  final String url;
  final GestureTapCallback onTap;
  const PictureDelete({Key key, @required this.url,@required this.onTap}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: 16),
      height: 100,
      width: 100,
      child: Stack(
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                image: DecorationImage(
                    image: NetworkImage(url), fit: BoxFit.cover)),
          ),
          Positioned(
            right: 10,
            top: 10,
            child: GestureDetector(
              onTap: onTap,
              child: CircleAvatar(
                radius: 15,
                backgroundColor: Colors.red,
                child: Icon(
                  Icons.close,
                  size: 15,
                  color: Colors.white,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
