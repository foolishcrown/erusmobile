import 'package:erusmobile/constrants/app_constrants.dart';
import 'package:erusmobile/scr/blocs/job_bloc.dart';
import 'package:erusmobile/scr/models/job_model.dart';
import 'package:erusmobile/scr/widgets/AlertDialogChecker.dart';
import 'package:flutter/material.dart';

class JobList extends StatefulWidget {

  final int companyId;

  const JobList({Key key, this.companyId}) : super(key: key);

  @override
  _JobListState createState() => _JobListState();
}

class _JobListState extends State<JobList> {
  final bloc = JobBloc();

  @override
  Widget build(BuildContext context) {
    bloc.fetchAllJobByCompanyId(companyId: 6, pageNum: 1).catchError((e) {
      showAlertTimeOutDialog(context, 'Alert', e.toString());
    });
    return Scaffold(
      body: StreamBuilder(
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
    );
  }


  Widget buildList(AsyncSnapshot<ItemJobModel> snapshot) {
    final sizeSpace2 = 5.0;

    return ListView.builder(
      itemCount: snapshot.data.jobs.length,
      itemBuilder: (context, index) {
        return Card(
          child: Padding(
            padding: const EdgeInsets.all(25.0),
            child: Column(
              children: [
                Container(
                    width: MediaQuery.of(context).size.width / 1.2,
                    child: Text(
                        snapshot.data.jobs[index].title,
                        style: AppFonts.comp_style_black(context)),
                    alignment: Alignment.centerLeft),
                SizedBox(
                  height: sizeSpace2,
                ),
                Container(width: MediaQuery.of(context).size.width / 1.2,
                    child: Text(snapshot.data.jobs[index].description),
                    alignment: Alignment.centerLeft),
                SizedBox(
                  height: sizeSpace2,
                ),
                Container(width: MediaQuery.of(context).size.width / 1.2,
                    child: Text("Reward: " + snapshot.data.jobs[index].reward.toString()),
                    alignment: Alignment.centerLeft),

              ],
            ),
          ),
        );
      },
    );
  }

}

