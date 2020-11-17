import 'package:erusmobile/constrants/app_constrants.dart';
import 'package:flutter/material.dart';

class DashboardContain extends StatefulWidget {
  @override
  _DashboardContainState createState() => _DashboardContainState();
}

class _DashboardContainState extends State<DashboardContain> {
  var spaceSizedBox = 15.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomPadding: false,
        body: Container(
            padding: const EdgeInsets.all(15.0),
            color: Colors.black.withOpacity(0.8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    color: Colors.white.withOpacity(0.7),
                  ),
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height / 4.5,
                  // color: Colors.white,
                  child: Column(
                    children: [
                      Container(
                        ///Title
                        child: Text("YOUR REFERRALS",
                            style: AppFonts.comp_title_black(context)),
                        alignment: Alignment.topLeft,
                      ),
                      Row(
                        ///Context
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width / 2,
                            color: Colors.black,
                          )
                        ],
                      )
                    ],
                  ),
                  padding: EdgeInsets.only(top: 10, left: 10),
                ),
                SizedBox(
                  height: spaceSizedBox,
                ),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    color: Colors.white.withOpacity(0.7),
                  ),
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height / 4.5,
                  // color: Colors.white,
                  child: Column(
                    children: [
                      Container(
                        ///Title
                        child: Text("YOUR RANKING",
                            style: AppFonts.comp_title_black(context)),
                        alignment: Alignment.topLeft,
                      ),
                      Row(
                        ///Context
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width / 2,
                            color: Colors.black,
                          )
                        ],
                      )
                    ],
                  ),
                  padding: EdgeInsets.only(top: 10, left: 10),
                ),
                SizedBox(
                  height: spaceSizedBox,
                ),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    color: Colors.white.withOpacity(0.7),
                  ),
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height / 4.5,
                  // color: Colors.white,
                  child: Column(
                    children: [
                      Container(
                        ///Title
                        child: Text("AVAILABLE JOBS",
                            style: AppFonts.comp_title_black(context)),
                        alignment: Alignment.topLeft,
                      ),
                      Row(
                        ///Context
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width / 2,
                            color: Colors.black,
                          )
                        ],
                      )
                    ],
                  ),
                  padding: EdgeInsets.only(top: 10, left: 10),
                ),
                SizedBox(
                  height: spaceSizedBox,
                ),
              ],
            )));
  }
}
