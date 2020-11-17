import 'package:erusmobile/constrants/app_constrants.dart';
import 'package:flutter/cupertino.dart';
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
                ///REFERRALS
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
                        margin: EdgeInsets.only(bottom: 10),
                      ),
                      Row(
                        ///Context
                        children: [
                          Container(
                            margin: EdgeInsets.only(right: 10),
                            child: Column(
                              children: [
                                Container(
                                  width: MediaQuery.of(context).size.width / 2.5,
                                  height: MediaQuery.of(context).size.height/10,
                                  decoration: BoxDecoration(
                                    borderRadius:
                                    BorderRadius.all(Radius.circular(20.0)),
                                    color: Colors.amber.withOpacity(0.3),
                                  ),
                                  child: Center(child: Text('20', style: AppFonts.title_style2(context),)),

                                ),
                                Container(
                                    alignment: Alignment.centerLeft,
                                    width: MediaQuery.of(context).size.width / 2.5,
                                    child: Center(child: Text('Referrals', style: AppFonts.comp_title_black(context),)))
                              ],

                            ),
                          ),
                          Column(
                            children: [
                              Container(
                                width: MediaQuery.of(context).size.width / 2.5,
                                height: MediaQuery.of(context).size.height/10,
                                decoration: BoxDecoration(
                                  borderRadius:
                                  BorderRadius.all(Radius.circular(20.0)),
                                  color: Colors.amber.withOpacity(0.3),
                                ),
                                child: Center(child: Text('100', style: AppFonts.title_style2(context),)),

                              ),
                              Container(
                                  alignment: Alignment.centerLeft,
                                  width: MediaQuery.of(context).size.width / 2.5,
                                  child: Center(child: Text('Scores', style: AppFonts.comp_title_black(context),)))
                            ],

                          ),
                        ],
                      ),

                    ],
                  ),
                  padding: EdgeInsets.only(top: 10, left: 10),
                ),
                SizedBox(
                  height: spaceSizedBox,
                ),

                ///
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
                        margin: EdgeInsets.only(bottom: 10),
                      ),
                      Row(
                        ///Context
                        children: [
                          Container(
                            margin: EdgeInsets.only(right: 10),
                            child: Column(
                              children: [
                                Container(
                                  width: MediaQuery.of(context).size.width / 2.5,
                                  height: MediaQuery.of(context).size.height/10,
                                  decoration: BoxDecoration(
                                    borderRadius:
                                    BorderRadius.all(Radius.circular(20.0)),
                                    color: Colors.amber.withOpacity(0.3),
                                  ),
                                  child: Center(child: Text('#1', style: AppFonts.title_style2(context),)),

                                ),
                                Container(
                                    alignment: Alignment.centerLeft,
                                    width: MediaQuery.of(context).size.width / 2.5,
                                    child: Center(child: Text('of all referrals', style: AppFonts.comp_title_black(context),)))
                              ],

                            ),
                          ),

                        ],
                      ),

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
                        margin: EdgeInsets.only(bottom: 10),
                      ),
                      Row(
                        ///Context
                        children: [
                          Container(
                            margin: EdgeInsets.only(right: 10),
                            child: Column(
                              children: [
                                Container(
                                  width: MediaQuery.of(context).size.width / 2.5,
                                  height: MediaQuery.of(context).size.height/10,
                                  decoration: BoxDecoration(
                                    borderRadius:
                                    BorderRadius.all(Radius.circular(20.0)),
                                    color: Colors.amber.withOpacity(0.3),
                                  ),
                                  child: Center(child: Text('4', style: AppFonts.title_style2(context),)),

                                ),
                                Container(
                                    alignment: Alignment.centerLeft,
                                    width: MediaQuery.of(context).size.width / 2.5,
                                    child: Center(child: Text('Jobs', style: AppFonts.comp_title_black(context),)))
                              ],

                            ),
                          ),

                        ],
                      ),

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
