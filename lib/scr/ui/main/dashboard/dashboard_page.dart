import 'package:erusmobile/scr/ui/main/dashboard/dashboard_container.dart';
import 'package:flutter/material.dart';

class DashboardPage extends StatefulWidget {
  final int empId;
  final int score;
  DashboardPage({@required this.empId,@required this.score});

  @override
  _DashboardPageState createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DashboardContain(empId: widget.empId, score: widget.score,),
    );
  }
}
