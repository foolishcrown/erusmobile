// ignore: avoid_web_libraries_in_flutter
// import 'dart:hasDatatml';


import 'package:erusmobile/constrants/app_constrants.dart';
import 'package:erusmobile/scr/blocs/candidate_skill_bloc.dart';
import 'package:erusmobile/scr/models/skill_candidate_model.dart';
import 'package:erusmobile/scr/widgets/AlertDialogChecker.dart';
import 'package:flutter/material.dart';


const double xLEVEL_RATIO = 0.2;


class CandidateSkillList extends StatefulWidget {

  final int canId;

  const CandidateSkillList({Key key, this.canId}) : super(key: key);



  @override
  _CandidateSkillListState createState() => _CandidateSkillListState();
}

class _CandidateSkillListState extends State<CandidateSkillList> {
  final bloc = CandidateSkillBloc();



  @override
  Widget build(BuildContext context) {
    bloc.fetchAllCandidateSkill(widget.canId).catchError((e) {
      showAlertTimeOutDialog(context, 'Alert', e.toString());
    });
    return Scaffold(
      body: StreamBuilder(
        stream: bloc.allSkill,
        builder: (context, AsyncSnapshot<ItemCandidateSkillModel> snapshot) {
          if (snapshot.hasData) {
            return buildList(snapshot);
          } else if (snapshot.hasError) {
            return Text(snapshot.error.toString());
          }
          return Center(child: CircularProgressIndicator());
        },
      ),
    );
  }

  Widget buildList(AsyncSnapshot<ItemCandidateSkillModel> snapshot) {
    final sizeSpace2 = 5.0;
    return ListView.builder(
      itemCount: snapshot.data.skills.length,
      itemBuilder: (context, index) {
        return Card(
          color: Colors.black.withOpacity(0.5),
          child: Padding(
            padding: const EdgeInsets.all(25.0),
            child: Column(
              children: [
                Container(
                    width: MediaQuery.of(context).size.width / 1.2,
                    child: Text('Skill : ' +
                        snapshot.data.skills[index].name,
                        style: AppFonts.comp_style_white(context)),
                    alignment: Alignment.centerLeft),
                SizedBox(
                  height: sizeSpace2,
                ),
                Row(
                  children: [
                    Text("Level : ", style: AppFonts.comp_style_detail_white(context),),
                    Container(width: MediaQuery.of(context).size.width *0.3,
                        child: LinearProgressIndicator(
                          backgroundColor: Colors.white,
                          valueColor: new AlwaysStoppedAnimation<Color>(Colors.blueGrey),
                          value: snapshot.data.skills[index].level * 0.5,
                        ),
                        alignment: Alignment.centerLeft),
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
