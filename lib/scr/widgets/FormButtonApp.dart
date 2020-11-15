import 'package:erusmobile/constrants/app_constrants.dart';
import 'package:erusmobile/scr/resources/google_sign_in.dart';
import 'package:erusmobile/scr/ui/main/main_page.dart';
import 'package:erusmobile/scr/widgets/LoadFilePDF.dart';
import 'package:flutter/material.dart';

import 'AlertDialogChecker.dart';

Widget loginButtonSubmit(BuildContext context) {
  final GlobalKey<State> _keyLoader = new GlobalKey<State>();
  return InkWell(
    onTap: () {
      signInWithGoogle(context, _keyLoader).then((result) {
        if (result != null) {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) {
                return MainPage();
              },
            ),
          );
        } else {
          signOutGoogle();
          showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: Text('Something wrong!',
                      style: AppFonts.title_style2(context)),
                  backgroundColor: AppThemes.theme_color,
                  content: Text(
                      'Your google account is not registered on app, please contact to your company!'),
                );
              });
        }
      }).catchError((e) {
        showAlertTimeOutDialog(context, 'Login Failed', e.toString());
      });
    },
    child: Container(
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.symmetric(vertical: 13),
      alignment: Alignment.center,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(5)),
          boxShadow: <BoxShadow>[
            BoxShadow(
                color: Colors.orangeAccent,
                offset: Offset(2, 4),
                blurRadius: 8,
                spreadRadius: 2)
          ],
          color: Colors.white),
      child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image(image: AssetImage("assets/google_logo.png"), height: 35.0),
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Text(
                'Login with company account',
                style: AppFonts.comp_style_black(context),
              ),
            )
          ]),
    ),
  );
}

Widget appBtnShowListDialog(
        BuildContext context, Widget listWidget, String title) =>
    InkWell(
      onTap: () {
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text(
                  title,
                  style: AppFonts.title_style2(context),
                ),
                actions: [
                  IconButton(
                    icon: Icon(Icons.add_box),
                    color: Colors.black,
                    onPressed: () {},
                  )
                ],
                backgroundColor: AppThemes.theme_color,
                content: listWidget,
              );
            });
      },
      child: Container(
        width: MediaQuery.of(context).size.width / 3,
        padding: EdgeInsets.symmetric(vertical: 5),
        alignment: Alignment.center,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(5)),
            boxShadow: <BoxShadow>[
              BoxShadow(
                color: Colors.grey,
                offset: Offset(0.3, 0.3),
                blurRadius: 0.5,
              )
            ],
            color: Colors.orangeAccent[100]),
        child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Text(
                  title,
                  style: AppFonts.comp_style_black(context),
                ),
              )
            ]),
      ),
    );

Widget appBtnShowImageDialog(
    {BuildContext context, String title, String file}) =>
    InkWell(
      onTap: () =>{
        LaunchFile.launchPDF(context: context, title: title, file: file),
      },
      child: Container(
        width: MediaQuery
            .of(context)
            .size
            .width / 3,
        padding: EdgeInsets.symmetric(vertical: 5),
        alignment: Alignment.center,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(5)),
            boxShadow: <BoxShadow>[
              BoxShadow(
                color: Colors.grey,
                offset: Offset(0.3, 0.3),
                blurRadius: 0.5,
              )
            ],
            color: Colors.orangeAccent[100]),
        child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Text(
                  title,
                  style: AppFonts.comp_style_black(context),
                ),
              )
            ]),
      ),
    );