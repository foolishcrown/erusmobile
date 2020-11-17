
import 'package:erusmobile/constrants/app_constrants.dart';
import 'package:erusmobile/scr/blocs/apply_candidate_bloc.dart';
import 'package:erusmobile/scr/models/apply_model.dart';
import 'package:erusmobile/scr/widgets/AlertDialogChecker.dart';
import 'package:flutter/material.dart';

class ReferralList extends StatefulWidget {
  final int empId;

  const ReferralList({Key key, @required this.empId}) : super(key: key);

  @override
  _ReferralListState createState() => _ReferralListState();
}

class _ReferralListState extends State<ReferralList> {
  final bloc = ApplyCandidateBloc();
  final LEVEL_RATIO = 0.25;
  @override
  Widget build(BuildContext context) {
    bloc.fetchAllApplyCandidate(empId: widget.empId).catchError((e) {
      showAlertTimeOutDialog(context, 'Alert', e.toString());
    });
    return Scaffold(
      body: StreamBuilder(
        stream: bloc.allApplies,
        builder: (context, AsyncSnapshot<ItemApplyCandidateModel> snapshot){
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

  Widget buildList(AsyncSnapshot<ItemApplyCandidateModel> snapshot){
    return ListView.builder(
        itemCount: snapshot.data.applyCandidate.length,
        itemBuilder: (context, index){
          return Container(
            // color: AppThemes.theme_color,

            child: Card(
              child: Container(
                padding: EdgeInsets.all(10),
                child: Column(
                  children: [
                    // Text(snapshot.data.applyCandidate[index].id),
                    Text(snapshot.data.applyCandidate[index].candidateName + " : "  + snapshot.data.applyCandidate[index].jobName, style: AppFonts.comp_title_black(context),),
                    SizedBox(
                      height: 10,
                    ),
                    Text('Apply date: ' + snapshot.data.applyCandidate[index].applyDate),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Level : ", style: AppFonts.comp_style_detail_white(context),),
                        Center(
                          child: Container(
                              height: 10,
                              width: MediaQuery.of(context).size.width/3,
                              child: LinearProgressIndicator(
                                backgroundColor: Colors.grey,
                                valueColor: new AlwaysStoppedAnimation<Color>(Colors.blueGrey),
                                value: snapshot.data.applyCandidate[index].phaseId * 0.5,
                              ),
                              alignment: Alignment.center),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Text('Status: ' + snapshot.data.applyCandidate[index].phaseName),
                  ],
                ),
              ),
            ),
          );
        },

    );
  }
}
