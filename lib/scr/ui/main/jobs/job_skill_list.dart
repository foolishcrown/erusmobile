// ignore: avoid_web_libraries_in_flutter
// import 'dart:hasDatatml';


import 'package:erusmobile/constrants/app_constrants.dart';
import 'package:erusmobile/scr/blocs/candidate_skill_bloc.dart';
import 'package:erusmobile/scr/blocs/required_skill_bloc.dart';
import 'package:erusmobile/scr/models/require_skill_model.dart';
import 'package:erusmobile/scr/models/skill_candidate_model.dart';
import 'package:erusmobile/scr/widgets/AlertDialogChecker.dart';
import 'package:flutter/material.dart';


const double LEVEL_RATIO = 0.2;


class RequiredSkillList extends StatefulWidget {

  final int jobId;

  const RequiredSkillList({Key key, this.jobId}) : super(key: key);



  @override
  _RequiredSkillListState createState() => _RequiredSkillListState();
}

class _RequiredSkillListState extends State<RequiredSkillList> {
  final bloc = RequiredSkillBloc();



  @override
  Widget build(BuildContext context) {
    bloc.fetchAllRequiredSkill(widget.jobId);
    return Scaffold(
      body: StreamBuilder(
        stream: bloc.allSkill,
        builder: (context, AsyncSnapshot<ItemRequiredSkillModel> snapshot) {
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

  Widget buildList(AsyncSnapshot<ItemRequiredSkillModel> snapshot) {
    final sizeSpace2 = 5.0;
    return ListView.builder(
      itemCount: snapshot.data.skills.length,
      shrinkWrap: true,
      physics: ScrollPhysics(),
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
                          value: snapshot.data.skills[index].level * LEVEL_RATIO,
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
