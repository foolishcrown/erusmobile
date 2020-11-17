import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Widget cardStatus({String label, String value}) => Container(
      margin: EdgeInsets.only(top: 20, right: 10),
      padding: EdgeInsets.all(8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(20.0)),
        color: Colors.white.withOpacity(0.5),
      ),
      child: Text(label + ': ' + value),
    );
