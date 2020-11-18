import 'package:erusmobile/scr/resources/google_sign_in.dart';
import 'package:erusmobile/scr/ui/login/login_page.dart';
import 'package:flutter/material.dart';

Widget drawerHeader(String username, String email) => UserAccountsDrawerHeader(
      accountName: Text(username),
      accountEmail: Text(email),
      currentAccountPicture: CircleAvatar(
        child: Icon(Icons.person_outline, size: 50,),
        backgroundColor: Colors.white,
      ),
      decoration: BoxDecoration(color: Colors.grey),
    );

Widget drawerItems(BuildContext context, String username, String email) =>
    ListView(
      children: <Widget>[
        drawerHeader(username, email),
        ListTile(
          title: Text("Account"),
          onTap: () => null,
        ),
        ListTile(
          title: Text("Notification"),
          onTap: () => null,
        ),
        ListTile(
          title: Text("Sign out"),
          onTap: () {
            signOutGoogle();
            Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (context) {
                  return LoginPage();
                }), ModalRoute.withName('/'));
          },
        ),
      ],

    );