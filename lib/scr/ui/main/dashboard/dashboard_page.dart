import 'package:erusmobile/constrants/app_constrants.dart';
import 'package:erusmobile/scr/widgets/NavDrawer.dart';
import 'package:flutter/material.dart';

class DashboardPage extends StatefulWidget {
  @override
  _DashboardPageState createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: AppThemes.theme_color,
          title: Text("Dashboard", style: AppFonts.title_style1(context)),
          centerTitle: true,
        ),
        drawer: Drawer(
          child: drawerItems(context),
        ),

      ),
    );
  }
}
