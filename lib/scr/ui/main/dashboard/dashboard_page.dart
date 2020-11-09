import 'dart:ffi';

import 'package:erusmobile/constrants/app_constrants.dart';
import 'package:erusmobile/scr/blocs/emp_account_bloc.dart';
import 'package:erusmobile/scr/models/emp_account_model.dart';
import 'package:erusmobile/scr/resources/authorize_token_store.dart';
import 'package:erusmobile/scr/ui/main/dashboard/dashboard_container.dart';
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
        body: DashboardContain(),
      ),
    );
  }
}
