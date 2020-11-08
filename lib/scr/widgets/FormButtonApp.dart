import 'package:erusmobile/constrants/app_constrants.dart';
import 'package:erusmobile/scr/widgets/LoadFilePDF.dart';
import 'package:flutter/material.dart';

Widget appBtnShowListDialog(BuildContext context, Widget listWidget, String title) =>
    InkWell(
      onTap: () {
        showDialog(context: context, builder: (BuildContext context) {
            return AlertDialog(
              title: Text(title, style: AppFonts.title_style2(context),),
              backgroundColor: AppThemes.theme_color,
              content: listWidget,
            );
        });
      },
      child: Container(
        width: MediaQuery
            .of(context)
            .size
            .width / 1.2,
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
            .width / 1.2,
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