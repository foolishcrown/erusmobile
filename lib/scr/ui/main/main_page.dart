import 'package:erusmobile/constrants/app_constrants.dart';
import 'package:erusmobile/scr/ui/main/candidates/candidate_page.dart';
import 'package:erusmobile/scr/ui/main/dashboard/dashboard_page.dart';
import 'package:erusmobile/scr/ui/main/jobs/job_page.dart';
import 'package:erusmobile/scr/ui/main/referrals/referral_page.dart';
import 'package:erusmobile/scr/widgets/NavDrawer.dart';
import 'package:flutter/material.dart';

/// This is the stateful widget that the main application instantiates.
class MainPage extends StatefulWidget {

  final int empId;

  const MainPage({Key key, this.empId}) : super(key: key);
  @override
  _MainPageState createState() => _MainPageState();
}

/// This is the private State class that goes with MyStatefulWidget.
class _MainPageState extends State<MainPage> {
  int _selectedIndex = 0;
  List<Widget> _widgetOptions(int empId) => <Widget>[
    DashboardPage(),
    JobsPage(),
    ReferralsPage(),
    CandidatesPage(empId: empId,)
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  ///Bottom Navigation Bar
  Widget _navBottom(BuildContext context) => BottomNavigationBar(
    items: const <BottomNavigationBarItem>[
      BottomNavigationBarItem(
        icon: Icon(Icons.dashboard),
        label: 'Dashboard',
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.list_alt),
        label: 'Jobs',
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.people),
        label: 'Referrals',
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.contact_page),
        label: 'Candidates',
      ),
    ],
    currentIndex: _selectedIndex,
    selectedItemColor: Colors.amber[800],
    unselectedItemColor: Colors.grey[800],
    onTap: _onItemTapped,
  );

  //Build
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
          child: _widgetOptions(widget.empId).elementAt(_selectedIndex),
        ),
        bottomNavigationBar: _navBottom(context),

    );
  }
}