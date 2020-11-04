import 'package:erusmobile/constrants/app_constrants.dart';
import 'package:erusmobile/scr/ui/main/jobs/job_list.dart';
import 'package:erusmobile/scr/widgets/NavDrawer.dart';
import 'package:flutter/material.dart';

class JobsPage extends StatefulWidget {
  @override
  _JobsPageState createState() => _JobsPageState();
}

class _JobsPageState extends State<JobsPage> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: AppThemes.theme_color,
          title: Text("Jobs", style: AppFonts.title_style1(context)),
          centerTitle: true,
        ),
        drawer: Drawer(
          child: drawerItems(context),
        ),
        body: JobList(companyId: 6),
      ),
    );
  }
}
