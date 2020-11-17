import 'package:erusmobile/constrants/app_constrants.dart';
import 'package:erusmobile/scr/ui/main/candidates/candidate_list.dart';

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
    return Scaffold(
      body: CandidateList(
        empId: widget.empId,
        isRefer: false,
      ),
    );
  }
}
