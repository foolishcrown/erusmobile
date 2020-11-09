import 'package:erusmobile/constrants/app_constrants.dart';
import 'package:erusmobile/scr/widgets/LoadFilePDF.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class LoadingState extends StatefulWidget {
  @override
  _LoadingState createState() => _LoadingState();
}

class _LoadingState extends State<LoadingState> {
  // void setupWaitTime() async{
  //   await Future.delayed(const Duration(seconds:1), () {
  //     setState(() {
  //       Navigator.push(context, new MaterialPageRoute(builder: (context) => MainPage()));
  //     });
  //   });
  // }
  // @override
  // void initState() {
  //   super.initState();
  //   setupWaitTime();
  // }
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
          ))),
    );
  }
}

class LoadingState2 extends StatefulWidget {
  final String title;
  final String file;

  LoadingState2({Key key, this.title, this.file}) : super(key: key);

  @override
  _LoadingState2 createState() => _LoadingState2();
}

class _LoadingState2 extends State<LoadingState2> {
  void setupWaitTime() async {
    await Future.delayed(const Duration(seconds: 2), () {
      setState(() {
        LaunchFile.launchPDF(
            context: context, title: widget.title, file: widget.file);
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
              ))),
    );
  }
}
