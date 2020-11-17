import 'package:erusmobile/constrants/app_constrants.dart';
import 'package:erusmobile/scr/blocs/company_bloc.dart';
import 'package:erusmobile/scr/ui/main/jobs/job_list.dart';
import 'package:erusmobile/scr/widgets/NavDrawer.dart';
import 'package:flutter/material.dart';

class JobsPage extends StatefulWidget {
  final int empId;

  const JobsPage({Key key, this.empId}) : super(key: key);

  @override
  _JobsPageState createState() => _JobsPageState();
}

class _JobsPageState extends State<JobsPage> {
  final bloc = CompanyBloc();

  @override
  Widget build(BuildContext context) {
    bloc.getCompanyId();
    print('EMPID : ' + widget.empId.toString());
    return Scaffold(
      body: StreamBuilder(
          stream: bloc.companyId,
          builder: (context, snapshot) {
            print('COMPANY ID : ' + snapshot.toString());
            if (snapshot.hasData) {
              return JobList(companyId: snapshot.data , empId: widget.empId);
            } else if (snapshot.hasError) {
              return Text(snapshot.error.toString());
            }
            return Center(child: CircularProgressIndicator());
          }),
    );
  }
}
