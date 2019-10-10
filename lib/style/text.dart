import 'package:flutter/material.dart';

abstract class StylesText {
  static const TextStyle loginTitle = TextStyle(
      color: Colors.white,
      fontSize: 26,
      fontStyle: FontStyle.normal,
      fontWeight: FontWeight.w700);

  static const TextStyle loginIntoPrimaryColor = TextStyle(
      color: Color(0xff0E1D4A),
      fontSize: 20,
      fontStyle: FontStyle.normal,
      fontWeight: FontWeight.w700);

  static const TextStyle loginIntoWhite = TextStyle(
      color: Colors.white,
      fontSize: 20,
      fontStyle: FontStyle.normal,
      fontWeight: FontWeight.w700);

  static TextStyle loginChange({Color color}) {
    return TextStyle(
        color: color,
        fontSize: 18,
        fontStyle: FontStyle.normal,
        fontWeight: FontWeight.w600);
  }

  static const TextStyle hintStyleWhite = TextStyle(color: Colors.white);

  static const TextStyle normalPrimaryColor = TextStyle(
    color: Color(0xff0E1D4A),
  );

  static const TextStyle normalPrimaryColor500 = TextStyle(
    color: Color(0xff0E1D4A),
    fontWeight: FontWeight.w500
  );

  static const TextStyle textLightBlack26md = TextStyle(
    color: Colors.black26,
    fontSize: 16.0,
    fontWeight: FontWeight.w700
  );

  static const TextStyle textblackmd = TextStyle(
    color: Colors.black,
    fontSize: 16.0,
    fontWeight: FontWeight.w700
  );
  
  static const TextStyle textTitleRegGym = TextStyle(
    color: Colors.black,
    fontSize: 16.0,
    fontWeight: FontWeight.w500
  );
   static const TextStyle textSubtitleRegGym = TextStyle(
    color: Colors.black,
    fontSize: 16.0,
    fontWeight: FontWeight.w300
  );

   static const TextStyle textBlack20w700 = TextStyle(
    color: Colors.black,
    fontSize: 20.0,
    fontWeight: FontWeight.w700
  );
  static const TextStyle textBlack16w700 = TextStyle(
    color: Colors.black,
    fontSize: 16.0,
    fontWeight: FontWeight.w700
  );
   static const TextStyle textBlack5416w700 = TextStyle(
    color: Colors.black54,
    fontSize: 16.0,
    fontWeight: FontWeight.w700
  );
   static const TextStyle textBlack20w500 = TextStyle(
    color: Colors.black,
    fontSize: 20.0,
    fontWeight: FontWeight.w500
  );
  static const TextStyle textBlue20w600 = TextStyle(
    color:Color(0xFF0E1D4A),
    fontSize: 20.0,
    fontWeight: FontWeight.w600
  );
  static const TextStyle textBlack14w500 = TextStyle(
    color: Colors.black,
    fontSize: 14.0,
    fontWeight: FontWeight.w500
  );
  static const TextStyle textBlack14w300 = TextStyle(
    color: Colors.black,
    fontSize: 14.0,
    fontWeight: FontWeight.w300
  );
  
}
