import 'package:erusmobile/constrants/app_constrants.dart';
import 'package:erusmobile/main.dart';
import 'package:flutter/material.dart';

class CandidateAddScreen extends StatefulWidget {
  String title;

  CandidateAddScreen({this.title});

  @override
  _CandidateAddScreenState createState() => _CandidateAddScreenState();
}

class _CandidateAddScreenState extends State<CandidateAddScreen> {
  final sizeSpace2 = 10.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomPadding: false,
        appBar: AppBar(
          backgroundColor: AppThemes.theme_color,
          title: Text(widget.title),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.save),
              onPressed: () {},
            ),
          ],
        ),
        body: new InkWell(
          splashColor: Colors.transparent,
          child: Container(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: <Widget>[
                // SizedBox(height: _animation.value),
                Container(
                  padding:EdgeInsets.symmetric(horizontal: 20, vertical: 10) ,
                  child: TextFormField(
                    autovalidateMode: AutovalidateMode.always,
                    decoration: InputDecoration(
                      labelText: 'First name',
                      icon: Icon(Icons.person),
                    ),
                    validator: (String value) {
                      return value.contains('@') ? 'Do not use the @ char.' : null;
                    },
                  ),
                ),
                Container(
                  padding:EdgeInsets.symmetric(horizontal: 20, vertical: 10) ,
                  child: TextFormField(
                    decoration: InputDecoration(
                      labelText: 'First name',
                      icon: Icon(Icons.person),

                    ),
                  ),
                ),
                Container(
                  padding:EdgeInsets.symmetric(horizontal: 20, vertical: 10) ,
                  child: TextFormField(
                    decoration: InputDecoration(
                      labelText: 'First name',
                      icon: Icon(Icons.person),

                    ),
                  ),
                ),
              ],
            ),
          ),
        )
    );
  }
}

// class CandidateAddScreen extends StatelessWidget {
//   String title;
//   final sizeSpace2 = 10.0;
//
//   CandidateAddScreen({this.title});
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         resizeToAvoidBottomPadding: false,
//         appBar: AppBar(
//         backgroundColor: AppThemes.theme_color,
//         title: Text(title),
//         actions: <Widget>[
//           IconButton(
//             icon: Icon(Icons.save),
//             onPressed: () {},
//           ),
//         ],
//       ),
//       body: new InkWell(
//         splashColor: Colors.transparent,
//         child: Container(
//           padding: const EdgeInsets.all(20.0),
//           child: Column(
//             children: <Widget>[
//               // SizedBox(height: _animation.value),
//               TextFormField(
//                 decoration: InputDecoration(
//                   labelText: 'First name',
//                   icon: Icon(Icons.person),
//                 ),
//               ),
//               TextFormField(
//                 decoration: InputDecoration(
//                   labelText: 'Last name',
//                   icon: Icon(Icons.person),
//                 ),
//               ),
//               TextFormField(
//                 decoration: InputDecoration(
//                   labelText: 'Email',
//                   icon: Icon(Icons.person),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       )
//     );
//   }
// }
