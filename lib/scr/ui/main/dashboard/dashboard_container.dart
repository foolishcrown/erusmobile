import 'package:erusmobile/constrants/app_constrants.dart';
import 'package:flutter/material.dart';

class DashboardContain extends StatefulWidget {
  @override
  _DashboardContainState createState() => _DashboardContainState();
}

class _DashboardContainState extends State<DashboardContain> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomPadding: false,
        body: Container(
            padding: const EdgeInsets.all(25.0),
            color: Colors.black,
            child: Column(
              children: [
                Container(
                    width: MediaQuery.of(context).size.width / 2,
                    child:
                        Text("test", style: AppFonts.comp_style_black(context)),
                    alignment: Alignment.centerLeft),
              ],
            )));
  }
}
