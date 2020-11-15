

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AppFonts {
  // This class is not meant to be instantiated or extended; this constructor
  // prevents instantiation and extension.
  // ignore: unused_element
  static const double FONT_LOGO_RATIO = 0.18;
  static const double FONT_TITLE_RATIO = 0.07;
  static const double FONT_COMP_RATIO = 0.04;
  static const double FONT_COMP_HIGHLIGHT_RATIO = 0.05;
  static const double FONT_COMP_DETAIL_RATIO = 0.03;


  AppFonts._();

  ///AppSize

  ///font style 1 - QUESTRIAL - App name font
  // static const TextStyle appname_style1 = TextStyle(fontFamily: 'Questrial', fontWeight: FontWeight.w400 , color: Colors.white, fontSize: 50);
  // static const TextStyle appname_style2 = TextStyle(fontFamily: 'Questrial', fontWeight: FontWeight.w400 , color: Colors.black, fontSize: 50);
  static TextStyle appname_style1(BuildContext context) {
    final size = MediaQuery
        .of(context)
        .size;
    double fontSize = size.width * FONT_LOGO_RATIO;
    return TextStyle(fontFamily: 'Questrial',
        fontWeight: FontWeight.w400,
        color: Colors.white,
        fontSize: fontSize);
  }

  static TextStyle appname_style2(BuildContext context) {
    final size = MediaQuery
        .of(context)
        .size;
    double fontSize = size.width * FONT_LOGO_RATIO;
    return TextStyle(fontFamily: 'Questrial',
        fontWeight: FontWeight.w400,
        color: Colors.black,
        fontSize: fontSize);
  }

  ///font style 1 - QUESTRIAL - title font
  // static const TextStyle title_style1 = TextStyle(fontFamily: 'Questrial', fontWeight: FontWeight.w400 , color: Colors.white, fontSize: 30);
  // static const TextStyle title_style2 = TextStyle(fontFamily: 'Questrial', fontWeight: FontWeight.w400 , color: Colors.black, fontSize: 30);
  static TextStyle title_style1(BuildContext context) {
    final size = MediaQuery
        .of(context)
        .size;
    double fontSize = size.width * FONT_TITLE_RATIO;
    return TextStyle(fontFamily: 'Questrial',
        fontWeight: FontWeight.w400,
        color: Colors.white,
        fontSize: fontSize);
  }

  static TextStyle title_style2(BuildContext context) {
    final size = MediaQuery
        .of(context)
        .size;
    double fontSize = size.width * FONT_TITLE_RATIO;
    return TextStyle(
        fontFamily: 'Questrial',
        fontWeight: FontWeight.w400,
        color: Colors.black,
        fontSize: fontSize);
  }

  ///font style 2 - OPEN SANS - component font
  // static const TextStyle comp_style_20_black = TextStyle(fontFamily: 'Open Sans', fontWeight: FontWeight.w700 , color: Colors.black, );
  // static const TextStyle comp_style_20_white = TextStyle(fontFamily: 'Open Sans', fontWeight: FontWeight.w700 , color: Colors.white, );

  static TextStyle comp_title_black(BuildContext context) {
    final size = MediaQuery.of(context).size;
    double fontSize = size.width * FONT_COMP_RATIO;
    return TextStyle(
        fontFamily: 'Open Sans',
        fontWeight: FontWeight.bold,
        color: Colors.black,
        fontSize: fontSize);
  }

  static TextStyle comp_style_black(BuildContext context) {
    final size = MediaQuery.of(context).size;
    double fontSize = size.width * FONT_COMP_RATIO;
    return TextStyle(
        fontFamily: 'Open Sans',
        fontWeight: FontWeight.w400,
        color: Colors.black,
        fontSize: fontSize);
  }

  static TextStyle comp_style_white(BuildContext context) {
    final size = MediaQuery
        .of(context)
        .size;
    double fontSize = size.width * FONT_COMP_RATIO;
    return TextStyle(fontFamily: 'Open Sans',
        fontWeight: FontWeight.w400,
        color: Colors.white,
        fontSize: fontSize);
  }

  static TextStyle comp_style_detail_white(BuildContext context) {
    final size = MediaQuery.of(context).size;
    double fontSize = size.width * FONT_COMP_DETAIL_RATIO;
    return TextStyle(
        fontFamily: 'Open Sans',
        fontWeight: FontWeight.w400,
        color: Colors.white,
        fontSize: fontSize);
  }

  static TextStyle comp_style_detail_red(BuildContext context) {
    final size = MediaQuery.of(context).size;
    double fontSize = size.width * FONT_COMP_DETAIL_RATIO;
    return TextStyle(
        fontFamily: 'Open Sans',
        fontWeight: FontWeight.w400,
        color: Colors.redAccent,
        fontSize: fontSize);
  }

// static const TextStyle comp_style_18 = TextStyle(fontFamily: 'Open Sans', fontWeight: FontWeight.w400 , color: Colors.black, fontSize: 16);
}
class AppThemes {

  AppThemes._();

  ///color theme app
  static const MaterialAccentColor theme_color = Colors.orangeAccent;
}


