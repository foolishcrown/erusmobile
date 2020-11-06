import 'package:erusmobile/scr/ui/login/login_page.dart';
import 'package:flutter/material.dart';


showDialogAlertTimeout(BuildContext context) {
  return showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Alert'),
        content: Text('Timeout authorize, try to login again!'),
        actions: <Widget>[
          FlatButton(
            child: Text('Ok'),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => LoginPage(),
                ),
              );
            },
          ),
        ],
      );
    },
  );
}