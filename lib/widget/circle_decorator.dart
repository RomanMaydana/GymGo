import 'package:flutter/material.dart';

class CircleDecorator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 116,
      width: double.infinity,
      // color: Theme.of(context).primaryColor,
      child: Stack(
        children: <Widget>[
          Positioned(
            right: 0,
            top: -110,
            child: Opacity(
              opacity: 0.1,
              child: Container(
                height: 300,
                width: 300,
                decoration: BoxDecoration(
                    color: Theme.of(context).accentColor,
                    shape: BoxShape.circle),
              ),
            ),
          ),
           Positioned(
            right: 50,
            top: -70,
            child: Opacity(
              opacity: 0.2,
              child: Container(
                height: 130,
                width: 130,
                decoration: BoxDecoration(
                    color: Theme.of(context).accentColor,
                    shape: BoxShape.circle),
              ),
            ),
          ),
          Positioned(
            right: 50,
            top: -30,
            child: 
               Container(
                height: 70,
                width: 70,
                decoration: BoxDecoration(
                    color: Theme.of(context).accentColor,
                    shape: BoxShape.circle),
              ),
            
          ),
          Positioned(
            left: -115,
            top: -115,
            child: Container(
              height: 200,
              width: 200,
              decoration: BoxDecoration(
                  color: Theme.of(context).accentColor, shape: BoxShape.circle),
            ),
          )
        ],
      ),
    );
  }
}
