
import 'package:erusmobile/scr/ui/login/login_page.dart';
import 'package:flutter/material.dart';
class MyApp extends StatelessWidget {
  static final appTitle = "ERus";

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: appTitle,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: LoginPage(title: appTitle),
    );
  }
}