import 'package:erusmobile/constrants/app_constrants.dart';
import 'package:erusmobile/scr/blocs/job_bloc.dart';
import 'package:erusmobile/scr/models/job_model.dart';
import 'package:erusmobile/scr/ui/main/candidates/candidate_list.dart';
import 'package:erusmobile/scr/ui/main/jobs/job_skill_list.dart';
import 'package:erusmobile/scr/widgets/AlertDialogChecker.dart';
import 'package:erusmobile/scr/widgets/statusCard.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class JobList extends StatefulWidget {
  final int companyId;
  final int empId;

  const JobList({Key key, @required this.companyId, @required this.empId})
      : super(key: key);

  @override
  _JobListState createState() => _JobListState();
}

class _JobListState extends State<JobList> {
  final bloc = JobBloc();
  ScrollController _sc = new ScrollController();

  @override
  Widget build(BuildContext context) {
    bloc
        .fetchAllJobByCompanyId(companyId: widget.companyId, pageNum: 1)
        .catchError((e) {
      showAlertTimeOutDialog(context, 'Alert', e.toString());
    });
    return Scaffold(
      body: Container(
        color: Colors.black.withOpacity(0.8),
        padding: EdgeInsets.all(20),
        child: StreamBuilder(
          stream: bloc.allJobs,
          builder: (context, AsyncSnapshot<ItemJobModel> snapshot) {
            if (snapshot.hasData) {
              return buildList(snapshot);
            } else if (snapshot.hasError) {
              return Text(snapshot.error.toString());
            }
            return Center(child: CircularProgressIndicator());
          },
        ),
      ),
    );
  }

  Widget buildList(AsyncSnapshot<ItemJobModel> snapshot) {
    final sizeSpace2 = 10.0;

    return ListView.builder(
      itemCount: snapshot.data.jobs.length,
      itemBuilder: (context, index) {
        return Card(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              // mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(
                  child: Container(
                    child: Text(snapshot.data.jobs[index].title,
                        style: AppFonts.comp_title_black(context)),
                  ),
                ),

                SizedBox(
                  height: sizeSpace2,
                ),
                // Container(
                //     width: MediaQuery.of(context).size.width / 1.2,
                //     child: Text(snapshot.data.jobs[index].description),
                //     alignment: Alignment.centerLeft),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      child: Center(
                        child: Row(
                          children: [
                            InkWell(
                              onTap: () {
                                showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        title: Text(
                                          'Description',
                                          style: AppFonts.title_style1(context),
                                        ),
                                        backgroundColor: AppThemes.theme_color,
                                        content: Column(
                                          children: [
                                            Text(
                                              snapshot
                                                  .data.jobs[index].description,
                                              style: AppFonts
                                                  .comp_style_detail_white(
                                                      context),
                                            ),

                                            ///Status
                                            Row(
                                              children: [
                                                cardStatus(
                                                    label: 'Reward',
                                                    value: snapshot
                                                        .data.jobs[index].reward
                                                        .toString()),
                                                cardStatus(
                                                    label: 'Slot',
                                                    value: snapshot
                                                        .data.jobs[index].slot
                                                        .toString()),
                                                // cardStatus(label: 'Available' , value: snapshot.data.jobs[index].status.toString()),
                                              ],
                                            ),

                                            ///list skill required
                                            Container(
                                              margin: EdgeInsets.only(top: 20),
                                              decoration: BoxDecoration(
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(5.0)),
                                                color: Colors.white
                                                    .withOpacity(0.5),
                                              ),
                                              height: MediaQuery.of(context)
                                                      .size
                                                      .height /
                                                  3,
                                              child: RequiredSkillList(
                                                  jobId: snapshot
                                                      .data.jobs[index].id),
                                            )
                                          ],
                                        ),
                                      );
                                    });
                              },
                              child: Container(
                                margin: EdgeInsets.only(right: 5),
                                padding: EdgeInsets.all(8),
                                // width: MediaQuery.of(context).size.width / 2.5,
                                decoration: BoxDecoration(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(5.0)),
                                  color: Colors.brown.withOpacity(0.3),
                                ),
                                // color: Colors.orangeAccent.withOpacity(0.2),
                                child: Row(
                                  children: [
                                    Icon(
                                      Icons.description,
                                      size: 30,
                                      color: Colors.brown,
                                    ),
                                    Text(
                                      'Description',
                                      style: AppFonts.comp_style_detail_black(
                                          context),
                                    )
                                  ],
                                ),
                              ),
                            ),
                            // SizedBox(
                            //   width: MediaQuery.of(context).size.width/10,
                            // ),
                            InkWell(
                              onTap: () {
                                showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        title: Text(
                                          'Select candidate',
                                          style: AppFonts.title_style1(context),
                                        ),
                                        backgroundColor: AppThemes.theme_color,
                                        content: CandidateList(
                                          empId: widget.empId,
                                          isRefer: true,
                                          jobId: snapshot.data.jobs[index].id,
                                        ),
                                      );
                                    });
                              },
                              child: Container(
                                width: MediaQuery.of(context).size.width / 4,
                                padding: EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(5.0)),
                                  color: Colors.black.withOpacity(0.3),
                                ),
                                // color: Colors.orangeAccent.withOpacity(0.2),
                                child: Row(
                                  children: [
                                    Icon(
                                      Icons.description,
                                      size: 30,
                                      color: Colors.black,
                                    ),
                                    Text(
                                      'Refer',
                                      style: AppFonts.comp_style_detail_black(
                                          context),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
