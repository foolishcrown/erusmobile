import 'package:erusmobile/scr/ui/login/login_page.dart';
import 'package:erusmobile/scr/ui/main/main_page.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class routePage extends StatefulWidget {

  @override
  routePageState createState() => routePageState();
}

class routePageState extends State<routePage> {
  final GoogleSignIn googleSignIn = GoogleSignIn();
  static bool isLoggedin = false;

  @override
  void initState() {
    super.initState();
    _checkConnection();
  }

  _checkConnection() async {
    print("Init state");
    isLoggedin = await googleSignIn.isSignedIn();
    print('Status : ' + isLoggedin.toString());
  }

  @override
  Widget build(BuildContext context) {
    return isLoggedin == true ? MainPage() : LoginPage();
  }
}
