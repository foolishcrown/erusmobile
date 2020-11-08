import 'package:erusmobile/constrants/app_constrants.dart';
import 'package:erusmobile/scr/resources/google_sign_in.dart';
import 'package:erusmobile/scr/ui/login/login_page.dart';
import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

Alert alertAuthorize(BuildContext context, String title, String desc, ) =>
    Alert(
      context: context,
      type: AlertType.error,
      title: title,
      desc: desc.substring(desc.indexOf(' ', 1)),

      buttons: [
        DialogButton(
          child: Text(
            "OK",
            style: AppFonts.comp_style_white(context),
          ),
          onPressed: (){
            signOutGoogle();
            Navigator.of(context, rootNavigator: true).pop();
            Navigator.of(context, rootNavigator: true).pushAndRemoveUntil(MaterialPageRoute(builder: (context) {return LoginPage();}), ModalRoute.withName('/'));
          } ,
          width: MediaQuery
              .of(context)
              .size
              .width / 2,
        )
      ],
    );