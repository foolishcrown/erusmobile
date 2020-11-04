import 'package:erusmobile/constrants/app_constrants.dart';
import 'package:erusmobile/scr/widgets/NavDrawer.dart';
import 'package:flutter/material.dart';

class ReferralsPage extends StatefulWidget {
  @override
  _ReferralsPageState createState() => _ReferralsPageState();
}

class _ReferralsPageState extends State<ReferralsPage> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: AppThemes.theme_color,
          title: Text("Referrals", style: AppFonts.title_style1(context)),
          centerTitle: true,
        ),
        drawer: Drawer(
          child: drawerItems(context),
        ),
      ),
    );
  }
}