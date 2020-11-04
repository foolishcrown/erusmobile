import 'package:erusmobile/constrants/app_constrants.dart';
import 'package:erusmobile/scr/ui/main/main_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';



class LoadingState extends StatefulWidget {
  final int empId;

  const LoadingState({Key key, this.empId}) : super(key: key);

  @override
  _LoadingState createState() => _LoadingState();
}

class _LoadingState extends State<LoadingState> {
  void setupWaitTime() async{
    await Future.delayed(const Duration(seconds:1), () {
      setState(() {
        Navigator.push(context, new MaterialPageRoute(builder: (context) => MainPage()));
      });
    });
  }
  @override
  void initState() {

    super.initState();
    setupWaitTime();
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
      ),
      home: Scaffold(
          backgroundColor: AppThemes.theme_color,
          body: Center(
              child: SpinKitFoldingCube(
                color: Colors.white,
                size: 50.0,
              )
          )
      ),
    );
  }
}