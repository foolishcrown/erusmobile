import 'package:erusmobile/constrants/app_constrants.dart';
import 'package:erusmobile/scr/blocs/emp_account_bloc.dart';
import 'package:erusmobile/scr/models/emp_account_model.dart';
import 'package:erusmobile/scr/ui/main/candidates/candidate_page.dart';
import 'package:erusmobile/scr/ui/main/dashboard/dashboard_page.dart';
import 'package:erusmobile/scr/ui/main/jobs/job_page.dart';
import 'package:erusmobile/scr/ui/main/referrals/referral_page.dart';
import 'package:erusmobile/scr/widgets/LoadingScreen.dart';
import 'package:erusmobile/scr/widgets/NavDrawer.dart';
import 'package:flutter/material.dart';

/// This is the stateful widget that the main application instantiates.
class MainPage extends StatefulWidget {
  final int empId;

  MainPage({Key key, this.empId}) : super(key: key);

  @override
  _MainPageState createState() => _MainPageState();
}

/// This is the private State class that goes with MyStatefulWidget.
class _MainPageState extends State<MainPage> {
  final bloc = EmpAccountBloc();
  int _selectedIndex = 0;

  List<Widget> _widgetOptions(int empId) => <Widget>[
        DashboardPage(),
        JobsPage(),
        ReferralsPage(),
        CandidatesPage(
          empId: empId,
        )
      ];

  List<String> _titleAppbar() =>
      <String>['Dashboard', 'Jobs', 'Referrals', 'Candidates'];

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
    bloc.getEmpAccount();
    return StreamBuilder(
        stream: bloc.empAccount,
        builder: (context, AsyncSnapshot<EmpAccount> snapshot) {
          if (snapshot.hasData) {
            return WillPopScope(
              onWillPop: () => showDialog<bool>(
                context: context,
                builder: (c) => AlertDialog(
                  title: Text('Warning'),
                  content: Text('Do you really want to exit'),
                  actions: [
                    FlatButton(
                      child: Text('Yes'),
                      onPressed: () => Navigator.pop(c, true),
                    ),
                    FlatButton(
                      child: Text('No'),
                      onPressed: () => Navigator.pop(c, false),
                    ),
                  ],
                ),
              ),
              child: Scaffold(
                appBar: AppBar(
                  backgroundColor: AppThemes.theme_color,
                  title: Text(_titleAppbar().elementAt(_selectedIndex),
                      style: AppFonts.title_style1(context)),
                  centerTitle: true,
                ),
                drawer: Drawer(
                    child: drawerItems(
                        context, snapshot.data.fullName, snapshot.data.email)),
                body: Center(
                  child: _widgetOptions(snapshot.data.id)
                      .elementAt(_selectedIndex),
                ),
                bottomNavigationBar: _navBottom(context),
              ),
            );
          } else if (snapshot.hasError) {
            return Text(snapshot.error.toString());
          }
          return LoadingState();
        });
  }
}
