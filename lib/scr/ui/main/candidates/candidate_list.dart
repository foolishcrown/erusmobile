import 'package:erusmobile/constrants/app_constrants.dart';
import 'package:erusmobile/scr/blocs/candidate_bloc.dart';
import 'package:erusmobile/scr/models/candidate_model.dart';
import 'package:erusmobile/scr/ui/main/candidates/candidate_infor.dart';
import 'package:erusmobile/scr/ui/main/candidates/candidate_skills_list.dart';
import 'package:erusmobile/scr/widgets/AlertDialogChecker.dart';
import 'package:erusmobile/scr/widgets/FormButtonApp.dart';
import 'package:flutter/material.dart';

class CandidateList extends StatefulWidget {
  final int empId;

  const CandidateList({Key key, this.empId}) : super(key: key);

  @override
  _CandidateListState createState() => _CandidateListState();
}

class _CandidateListState extends State<CandidateList> {
  final bloc = CandidateBloc();

  @override
  Widget build(BuildContext context) {
    bloc.fetchAllCandidate(empId: widget.empId, pageNum: 1).catchError((e) {
      showAlertTimeOutDialog(context, 'Alert', e.toString());
    });
    return Scaffold(
      body: Container(
        color: Colors.black.withOpacity(0.8),
        padding: const EdgeInsets.all(15.0),
        child: StreamBuilder(
          stream: bloc.allCandidates,
          builder: (context, AsyncSnapshot<ItemCandidateModel> snapshot) {
            if (snapshot.hasData) {
              return buildList(snapshot);
            } else if (snapshot.hasError) {
              return Text(snapshot.error.toString());
            }
            return Center(child: CircularProgressIndicator());
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) =>
                    CandidateInfo(isCreate: true, empId: widget.empId),
              ));
        },
        tooltip: 'Add new candidate',
        child: Icon(Icons.person_add_alt_1),
      ), // This trailing co
    );
  }

  Widget buildList(AsyncSnapshot<ItemCandidateModel> snapshot) {
    final sizeSpace1 = 15.0;
    final sizeSpace2 = 5.0;

    return ListView.builder(
      itemCount: snapshot.data.candidates.length,
      itemBuilder: (context, index) {
        return Card(
          // color: Colors.white.withOpacity(0.9),
          child: Padding(
            padding: const EdgeInsets.all(25.0),
            child: Column(
              children: [
                Row(
                  children: [
                    Container(
                      padding: EdgeInsets.only(top: 5),
                      height: MediaQuery.of(context).size.height / 7,
                      child: Column(
                        children: [
                          Container(
                              width: MediaQuery.of(context).size.width / 2,
                              child: Text(
                                  snapshot.data.candidates[index].fullname,
                                  style: AppFonts.comp_style_black(context)),
                              alignment: Alignment.centerLeft),
                          SizedBox(
                            height: sizeSpace2,
                          ),
                          Container(
                              width: MediaQuery.of(context).size.width / 2,
                              child: Text("Phone: " +
                                  snapshot.data.candidates[index].phone),
                              alignment: Alignment.centerLeft),
                          SizedBox(
                            height: sizeSpace2,
                          ),
                          Container(
                              width: MediaQuery.of(context).size.width / 2,
                              child: Text("Email: " +
                                  snapshot.data.candidates[index].email),
                              alignment: Alignment.centerLeft),
                        ],
                      ),
                    ),
                    Container(
                      height: MediaQuery.of(context).size.height / 6,
                      width: MediaQuery.of(context).size.width / 3.5,
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
                              iconSize: 30,
                              color: Colors.redAccent,
                              icon: Icon(Icons.delete),
                              onPressed: () {},
                            ),
                          ),
                          SizedBox(
                            height: 3,
                          ),

                          ///Update button
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
                                print('EMPID 1: ' + widget.empId.toString());
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => CandidateInfo(
                                        candidateId:
                                            snapshot.data.candidates[index].id,
                                        isCreate: false,
                                        empId: widget.empId,
                                      ),
                                    ));
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
                appBtnShowListDialog(
                    context,
                    CandidateSkillList(
                        canId: snapshot.data.candidates[index].id),
                    'Skills'),
                SizedBox(
                  height: sizeSpace1,
                ),
                appBtnShowImageDialog(
                    context: context,
                    title: 'Resume',
                    file: snapshot.data.candidates[index].resumeFile),
              ],
            ),
          ),
        );
      },
    );
  }
}
