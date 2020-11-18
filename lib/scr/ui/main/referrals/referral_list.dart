import 'package:erusmobile/constrants/app_constrants.dart';
import 'package:erusmobile/scr/blocs/apply_candidate_bloc.dart';
import 'package:erusmobile/scr/models/apply_model.dart';
import 'package:erusmobile/scr/widgets/AlertDialogChecker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';

class ReferralList extends StatefulWidget {
  final int empId;

  const ReferralList({Key key, @required this.empId}) : super(key: key);

  @override
  _ReferralListState createState() => _ReferralListState();
}

class _ReferralListState extends State<ReferralList> {
  final bloc = ApplyCandidateBloc();

  @override
  Widget build(BuildContext context) {
    bloc.fetchAllApplyCandidate(empId: widget.empId).catchError((e) {
      showAlertTimeOutDialog(context, 'Alert', e.toString());
    });
    return Scaffold(
      body: StreamBuilder(
        stream: bloc.allApplies,
        builder: (context, AsyncSnapshot<ItemApplyCandidateModel> snapshot) {
          if (snapshot.hasData) {
            return Container(
                color: Colors.black.withOpacity(0.7),
                padding: EdgeInsets.all(10),
                child: buildList(snapshot));
          } else if (snapshot.hasError) {
            return Text(snapshot.error.toString());
          }
          return Center(child: CircularProgressIndicator());
        },
      ),
    );
  }

  Widget convertDate(String datetime){
    DateTime tempDate = new DateFormat("yyyy-MM-dd").parse(datetime);
    String date = DateFormat("yyyy-MM-dd").format(tempDate);
    return Text(date, style:
    TextStyle(fontSize: 15, fontWeight: FontWeight.bold));
  }

  Widget buildList(AsyncSnapshot<ItemApplyCandidateModel> snapshot) {
    return ListView.builder(
      itemCount: snapshot.data.applyCandidate.length,
      itemBuilder: (context, index) {
        return Card(
          child: Padding(
            padding: EdgeInsets.all(10),
            child: Column(
              children: [
                Row(
                  children: [
                    Text(
                      snapshot.data.applyCandidate[index].candidateName,
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      child: Text('  / ',style:
                      TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
                      width: 20,
                    ), // chỉnh sữa nếu cần
                    Text(
                      "Reward : " + snapshot.data.applyCandidate[index].reward.toString(),
                      style:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    Text(
                      snapshot.data.applyCandidate[index].jobName,
                      style:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      child: Text('  / ',style:
                      TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
                      width: 20,
                    ), // chỉnh sữa nếu cần
                    Expanded(
                      child: convertDate(snapshot.data.applyCandidate[index].applyDate),
                    ),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),

                // thẻ duyệt các step
                StepProgressIndicator(
                    totalSteps: 5,
                    currentStep: snapshot.data.applyCandidate[index].phaseId,
                    // chỗ này là thay dổi trang thái của step từ 0 dến 5
                    size: 70,
                    selectedColor: Colors.black,
                    unselectedColor: Colors.grey[200],
                    customStep: (index, color, step) => color == Colors.black
                        ? snapshot.data.applyCandidate[index].phaseId == 5 ?
                    Column(
                      children: [
                        Container(
                          color: color,
                          child: Icon(
                            Icons.close,
                            color: Colors.redAccent,
                          ),
                        ),
                        Text('Reject'),
                      ],
                    )
                    : Column(
                            children: [
                              Container(
                                color: color,
                                child: Icon(
                                  Icons.check,
                                  color: Colors.white,
                                ),
                              ),
                              Text(snapshot.data.applyCandidate[index].phaseName),
                            ],
                          )
                        : Column(
                            children: [
                              Container(
                                color: color,
                                child: Icon(
                                  Icons.remove,
                                ),
                              ),
                              Text("Waiting"),
                            ],
                          )
                ),
              snapshot.data.applyCandidate[index].reward != 0 ? FlatButton(
                onPressed: (){
                  ///GET REWARD
                },
                child: Container(
                    decoration: BoxDecoration(
                      borderRadius:
                      BorderRadius.all(Radius.circular(5.0)),
                      color: Colors.black,
                    ),
                    padding: EdgeInsets.all(5),
                    child: Text('Get Reward',style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold , color: Colors.white), )),
              ) : Text(''),
                (snapshot.data.applyCandidate[index].phaseId == 4 || snapshot.data.applyCandidate[index].phaseId == 5) && snapshot.data.applyCandidate[index].reward == 0 ? FlatButton(
                  onPressed: (){
                    ///REMOVE APPLY

                  },
                  child: Container(
                      decoration: BoxDecoration(
                        borderRadius:
                        BorderRadius.all(Radius.circular(5.0)),
                        color: Colors.black,
                      ),
                      padding: EdgeInsets.all(5),
                      child: Text('Remove',style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold , color: Colors.white), )),
                ) : Text('')
          ],
            ),
          ),
        );
        // return Card(
        //   child: Container(
        //     padding: EdgeInsets.all(10),
        //     child: Column(
        //       children: [
        //         // Text(snapshot.data.applyCandidate[index].id),
        //         Text(snapshot.data.applyCandidate[index].candidateName + " : "  + snapshot.data.applyCandidate[index].jobName, style: AppFonts.comp_title_black(context),),
        //         SizedBox(
        //           height: 10,
        //         ),
        //         Text('Apply date: ' + snapshot.data.applyCandidate[index].applyDate),
        //         SizedBox(
        //           height: 10,
        //         ),
        //         Row(
        //           // mainAxisAlignment: MainAxisAlignment.,
        //           children: [
        //             Text("Level : ", style: AppFonts.comp_style_detail_white(context),),
        //             Container(
        //                 height: 10,
        //                 width: MediaQuery.of(context).size.width/1.45,
        //                 child: LinearProgressIndicator(
        //                   backgroundColor: Colors.orangeAccent.withOpacity(0.3),
        //                   valueColor: new AlwaysStoppedAnimation<Color>(snapshot.data.applyCandidate[index].phaseId < 5 ? Colors.greenAccent : Colors.redAccent),
        //                   value: (snapshot.data.applyCandidate[index].phaseId-1) * 0.33333,
        //                 ),
        //                 alignment: Alignment.centerLeft),
        //           ],
        //         ),
        //         SizedBox(
        //           height: 30,
        //         ),
        //         Text('Status: ' + snapshot.data.applyCandidate[index].phaseName),
        //       ],
        //     ),
        //   ),
        // );
      },
    );
  }
}
