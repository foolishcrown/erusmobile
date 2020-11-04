import 'package:erusmobile/constrants/app_constrants.dart';
import 'package:flutter/material.dart';
Widget appTitle(BuildContext context) {
  return RichText(
    textAlign: TextAlign.center,
    text: TextSpan(
        text: 'E',
        style: AppFonts.appname_style2(context),
        children: [
          TextSpan(
            text: 'R',
            style: AppFonts.appname_style1(context),
          ),
          TextSpan(
            text: 'us',
            style: AppFonts.appname_style1(context),
          ),
        ]),
  );
}