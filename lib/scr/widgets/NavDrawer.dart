import 'package:erusmobile/scr/resources/google_sign_in.dart';
import 'package:erusmobile/scr/ui/login/login_page.dart';
import 'package:flutter/material.dart';

const Widget drawerHeader = UserAccountsDrawerHeader(
  accountName: Text("SangNV16"),
  accountEmail: Text("sangnv16@fsoft.com.vn"),
  currentAccountPicture: CircleAvatar(
    child: FlutterLogo(size: 42,),
    backgroundColor: Colors.white,
  ),
  decoration: BoxDecoration(color: Colors.grey),
);

Widget drawerItems(BuildContext context) => ListView(
  children: <Widget>[
    drawerHeader,
    ListTile(
      title: Text("Setting"),
      onTap: () => null,
    ),
    ListTile(
      title: Text("Setting2"),
      onTap: () => null,
    ),
    ListTile(
      title: Text("Sign out"),
      onTap: () {
        signOutGoogle();
        Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) {return LoginPage();}), ModalRoute.withName('/'));
      },
    ),
  ],

);