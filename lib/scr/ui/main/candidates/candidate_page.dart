
import 'package:erusmobile/constrants/app_constrants.dart';
import 'file:///D:/FPTU/Workspace/erusmobile/lib/scr/ui/main/candidates/candidate_list.dart';
import 'package:erusmobile/scr/widgets/NavDrawer.dart';
import 'package:flutter/material.dart';

class CandidatesPage extends StatefulWidget {

  final int empId;

  const CandidatesPage({Key key, this.empId}) : super(key: key);

  @override
  _CandidatesPageState createState() => _CandidatesPageState();
}

class _CandidatesPageState extends State<CandidatesPage> {


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
          appBar: AppBar(
            backgroundColor: AppThemes.theme_color,
            title: Text("Candidates", style: AppFonts.title_style1(context)),
            centerTitle: true,
          ),
          drawer: Drawer(
            child: drawerItems(context),
          ),
          body: CandidateList(empId: widget.empId, ),
          ),
    );
  }
}
