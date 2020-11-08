import 'dart:async';
import 'dart:io';
import 'package:erusmobile/scr/widgets/LoadFilePDF.dart';
import 'package:flutter/cupertino.dart';

class PDFFileBloc{
  StreamController _pathPDF = new StreamController();

  Stream get pathPDF =>_pathPDF.stream;

  // 3
  void getPath(BuildContext context,String file) async {
    LaunchFile.loadFromFirebase(context, file).then((url) => LaunchFile.createFileFromPdfUrl(url).then((f) => {
      if(f is File){
        print('PathPDF : ' + f.path),
        _pathPDF.sink.add(f.path),

      } else if(f is Uri){
        _pathPDF.sink.addError(f.toString())
      }
    })).catchError((e) {
      throw e;
    });
  }

  // 4
  @override
  void dispose() {
    _pathPDF.close();
  }


}