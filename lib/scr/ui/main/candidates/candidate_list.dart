import 'dart:async';

import 'package:erusmobile/constrants/app_constrants.dart';
import 'package:erusmobile/scr/blocs/apply_candidate_bloc.dart';
import 'package:erusmobile/scr/blocs/candidate_bloc.dart';
import 'package:erusmobile/scr/blocs/skill_bloc.dart';
import 'package:erusmobile/scr/models/candidate_model.dart';
import 'package:erusmobile/scr/models/skill_model.dart';
import 'package:erusmobile/scr/ui/main/candidates/candidate_infor.dart';
import 'package:erusmobile/scr/ui/main/candidates/candidate_skills_list.dart';
import 'package:erusmobile/scr/ui/main/skills/skill_list.dart';
import 'package:erusmobile/scr/widgets/AlertDialogChecker.dart';
import 'package:erusmobile/scr/widgets/FormButtonApp.dart';
import 'package:erusmobile/scr/widgets/LoadingScreen.dart';
import 'package:erusmobile/scr/widgets/SearchPage.dart';
import 'package:flutter/material.dart';

class CandidateList extends StatefulWidget {
  final int empId;
  final bool isRefer;
  final int jobId;

  const CandidateList(
      {Key key, @required this.empId, @required this.isRefer, this.jobId})
      : super(key: key);

  @override
  _CandidateListState createState() => _CandidateListState();
}

class _CandidateListState extends State<CandidateList> {
  final bloc = CandidateBloc();
  final blocApply = ApplyCandidateBloc();
  final GlobalKey<State> _keyLoader = new GlobalKey<State>();


  @override
  Widget build(BuildContext context) {
    bloc.fetchAllCandidate(empId: widget.empId, pageNum: 1).catchError((e) {
      showAlertTimeOutDialog(context, 'Alert', e.toString());
    });
    return Scaffold(
      body: StreamBuilder(
        stream: bloc.allCandidates,
        builder: (context, AsyncSnapshot<ItemCandidateModel> snapshot) {
          if (snapshot.hasData) {
            if (widget.isRefer) {
              return Container(
                  color: Colors.white.withOpacity(0.3),
                  padding: EdgeInsets.all(10),
                  child: buildReferList(snapshot));
            } else {
              return Container(
                  color: Colors.black.withOpacity(0.7),
                  padding: EdgeInsets.all(10),
                  child: buildList(snapshot));
            }
          } else if (snapshot.hasError) {
            return Text(snapshot.error.toString());
          }
          return Center(child: CircularProgressIndicator());
        },
      ),

      ///ADD NEW CANDIDATE BUTTON
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) =>
                    CandidateInfo(isCreate: true, empId: widget.empId),
              )).then((value) => setState(() {}));
        },
        tooltip: 'Add new candidate',
        child: Icon(Icons.person_add_alt_1),
      ), // This trailing co
    );
  }

  void setupWaitTimeResponse(
      {String successMsg, String failMsg, bool status}) async {
    if (status) {
      Scaffold.of(context).showSnackBar(SnackBar(content: Text(successMsg)));
      await Future.delayed(const Duration(seconds: 1))
          .then((value) => {Navigator.pop(context)});
    } else {
      Scaffold.of(context).showSnackBar(SnackBar(content: Text(failMsg)));
      await Future.delayed(const Duration(seconds: 1))
          .then((value) => {Navigator.pop(context)});
    }
  }

  void showStateMsg({String successMsg, String failMsg, bool status}){
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(
              status ? successMsg : failMsg,
              style: AppFonts.title_style1(context),
            ),
            backgroundColor: AppThemes.theme_color,
            actions: [
              new FlatButton(
                child: new Text("Back"),
                onPressed: () {
                  Navigator.pop(context);
                  Navigator.pop(context);
                },
              ),
            ],
          ) ;
        });
  }

  ///BUILD SELECT LIST
  Widget buildReferList(AsyncSnapshot<ItemCandidateModel> snapshot) {
    // final sizeSpace1 = 15.0;
    final sizeSpace2 = 5.0;

    return ListView.builder(
      itemCount: snapshot.data.candidates.length,
      itemBuilder: (context, index) {
        return InkWell(
          onTap: () {
            showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: Text('Message'),
                    content: new SingleChildScrollView(
                      child: Text('You want to refer this candidate ?'),
                    ),
                    actions: <Widget>[
                      new FlatButton(
                        child: new Text("Yes"),
                        onPressed: () {
                          Navigator.pop(context);
                          Dialogs.showLoadingDialog(context, _keyLoader);
                          blocApply
                              .applyCandidate(
                              canId: snapshot.data
                                  .candidates[index].id,
                              jobId: widget.jobId)
                              .catchError((e) {
                            showAlertTimeOutDialog(context,
                                'Alert', e.toString());
                          });
                          blocApply.applyState.stream.first
                              .then(
                                  (value) =>
                              {

                                showStateMsg(
                                    successMsg:
                                    'Apply Success',
                                    failMsg: 'Apply Fail, candidate has been apply for this job',
                                    status: value)
                              });
                          },
                      ),
                      new FlatButton(
                        child: new Text("No"),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                    ],
                  );
                });
          },
          child: Card(
            color: Colors.black.withOpacity(0.5),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                padding: EdgeInsets.only(top: 5),
                height: MediaQuery
                    .of(context)
                    .size
                    .height / 7,
                child: Column(
                  children: [
                    Container(
                        width: MediaQuery
                            .of(context)
                            .size
                            .width / 2,
                        child: Text(snapshot.data.candidates[index].fullname,
                            style: AppFonts.comp_title_white(context)),
                        alignment: Alignment.centerLeft),
                    SizedBox(
                      height: sizeSpace2,
                    ),
                    Container(
                        width: MediaQuery
                            .of(context)
                            .size
                            .width / 2,
                        child: Text(
                            "Phone: " + snapshot.data.candidates[index].phone,
                            style: AppFonts.comp_style_detail_white(context)),
                        alignment: Alignment.centerLeft),
                    SizedBox(
                      height: sizeSpace2,
                    ),
                    Container(
                        width: MediaQuery
                            .of(context)
                            .size
                            .width / 2,
                        child: Text(
                            "Email: " + snapshot.data.candidates[index].email,
                            style: AppFonts.comp_style_detail_white(context)),
                        alignment: Alignment.centerLeft),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  ///BUILD LIST CANDIDATE
  Widget buildList(AsyncSnapshot<ItemCandidateModel> snapshot) {
    final sizeSpace1 = 15.0;
    final sizeSpace2 = 5.0;

    return ListView.builder(
      itemCount: snapshot.data.candidates.length,
      itemBuilder: (context, index) {
        return Card(
          // color: Colors.white.withOpacity(0.9),
          child: Container(
            padding: const EdgeInsets.all(15),
            child: Column(
              children: [
                Row(
                  children: [
                    Container(
                      margin: EdgeInsets.only(right: MediaQuery.of(context).size.width/6),
                      padding: EdgeInsets.only(top: 5),
                      height: MediaQuery
                          .of(context)
                          .size
                          .height / 7,
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            Container(
                                width: MediaQuery
                                    .of(context)
                                    .size
                                    .width / 2,
                                child: Text(
                                    snapshot.data.candidates[index].fullname,
                                    style: AppFonts.comp_title_black(context)),
                                alignment: Alignment.centerLeft),
                            SizedBox(
                              height: sizeSpace2,
                            ),
                            Container(
                                width: MediaQuery
                                    .of(context)
                                    .size
                                    .width / 2,
                                child: Text("Phone: " +
                                    snapshot.data.candidates[index].phone),
                                alignment: Alignment.centerLeft),
                            SizedBox(
                              height: sizeSpace2,
                            ),
                            Container(
                                width: MediaQuery
                                    .of(context)
                                    .size
                                    .width / 2,
                                child: Text("Email: " +
                                    snapshot.data.candidates[index].email),
                                alignment: Alignment.centerLeft),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      // height: MediaQuery
                      //     .of(context)
                      //     .size
                      //     .height / 6,
                      // width: MediaQuery
                      //     .of(context)
                      //     .size
                      //     .width / 3.5,
                      alignment: Alignment.topRight,
                      // color: Colors.blue,
                      child: Column(
                        children: [
                          ///Delete button
                          Container(
                            decoration: BoxDecoration(
                              borderRadius:
                              BorderRadius.all(Radius.circular(5.0)),
                              color: Colors.deepOrangeAccent.withOpacity(0.3),
                            ),
                            // color: Colors.orangeAccent.withOpacity(0.2),
                            child: IconButton(
                              iconSize: 20,
                              color: Colors.redAccent,
                              icon: Icon(Icons.delete),
                              onPressed: () {
                                showDialog(
                                    context: context,
                                    builder: (context) {
                                      return AlertDialog(
                                        title: Text('Message'),
                                        content: new SingleChildScrollView(
                                          child: Text('You want to delete ?'),
                                        ),
                                        actions: <Widget>[
                                          new FlatButton(
                                            child: new Text("Yes"),
                                            onPressed: () {
                                              Navigator.pop(context);
                                              Dialogs.showLoadingDialog(
                                                  context, _keyLoader);
                                              bloc
                                                  .deleteCandidateById(
                                                  canId: snapshot.data
                                                      .candidates[index].id)
                                                  .catchError((e) {
                                                showAlertTimeOutDialog(context,
                                                    'Alert', e.toString());
                                              });
                                              bloc.deleteStatus.stream.first
                                                  .then(
                                                    (value) =>
                                                {
                                                  setState(() {}),
                                                  setupWaitTimeResponse(
                                                      successMsg:
                                                      'Delete Success',
                                                      failMsg: 'Delete Fail',
                                                      status: value)
                                                },
                                                // }
                                              );
                                            },
                                          ),
                                          new FlatButton(
                                            child: new Text("No"),
                                            onPressed: () {
                                              Navigator.pop(context);
                                            },
                                          ),
                                        ],
                                      );
                                    });
                              },
                            ),
                          ),
                          SizedBox(
                            height: 3,
                          ),

                          ///EDIT CANDIDATE button
                          Container(
                            decoration: BoxDecoration(
                              borderRadius:
                              BorderRadius.all(Radius.circular(5.0)),
                              color: Colors.amber.withOpacity(0.3),
                            ),
                            // color: Colors.orangeAccent.withOpacity(0.2),
                            child: IconButton(
                              iconSize: 30,
                              color: Colors.amber,
                              icon: Icon(Icons.edit_outlined),
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          CandidateInfo(
                                            candidateId:
                                            snapshot.data.candidates[index].id,
                                            isCreate: false,
                                            empId: widget.empId,
                                          ),
                                    )).then((value) => setState(() {}));
                              },
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: sizeSpace1,
                ),
                Row(
                  children: [
                    // return appBtnShowListDialog(
                    //     context : context,
                    //      listWidget: CandidateSkillList(
                    //          canId: snapshot.data.candidates[index].id),
                    // title: 'Skills',
                    // data: snapshotSkill.data);
                    InkWell(
                      onTap: () {
                        showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: Text(
                                  'Skills',
                                  style: AppFonts.title_style2(context),
                                ),
                                actions: [
                                  InkWell(
                                    onTap: () {
                                      showSearch(
                                        context: context,
                                        delegate: CustomSearchDelegate(
                                            snapshot.data.candidates[index].id),
                                      );
                                    },
                                    child: Container(
                                      padding: EdgeInsets.all(8),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(5.0)),
                                        color: Colors.lightGreenAccent
                                            .withOpacity(0.7),
                                      ),
                                      // color: Colors.orangeAccent.withOpacity(0.2),
                                      child: Row(
                                        children: [
                                          Icon(
                                            Icons.add_box_outlined,
                                            size: 30,
                                            color: Colors.black,
                                          ),
                                          Text(
                                            'Add Skill',
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                                backgroundColor: AppThemes.theme_color,
                                content: CandidateSkillList(
                                    canId: snapshot.data.candidates[index].id),
                              );
                            });
                      },
                      child: Container(
                        width: MediaQuery
                            .of(context)
                            .size
                            .width / 3,
                        padding: EdgeInsets.symmetric(vertical: 5),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(5)),
                            boxShadow: <BoxShadow>[
                              BoxShadow(
                                color: Colors.grey,
                                offset: Offset(0.3, 0.3),
                                blurRadius: 0.5,
                              )
                            ],
                            color: Colors.orangeAccent[100]),
                        child: Row(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.only(left: 10),
                                child: Text(
                                  'Skills',
                                  style: AppFonts.comp_style_black(context),
                                ),
                              )
                            ]),
                      ),
                    ),
                    SizedBox(
                      width: MediaQuery
                          .of(context)
                          .size
                          .width / 10,
                    ),
                    appBtnShowImageDialog(
                        context: context,
                        title: 'Resume',
                        file: snapshot.data.candidates[index].resumeFile),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
