// import 'package:erusmobile/constrants/app_constrants.dart';
// import 'package:erusmobile/scr/blocs/skill_bloc.dart';
// import 'package:erusmobile/scr/models/skill_model.dart';
// import 'package:erusmobile/scr/widgets/AlertDialogChecker.dart';
// import 'package:erusmobile/scr/widgets/SearchPage.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_spinkit/flutter_spinkit.dart';
//
// class SkillPage extends StatefulWidget {
//   @override
//   _SkillPageState createState() => _SkillPageState();
// }
//
// class _SkillPageState extends State<SkillPage> {
//   final bloc = SkillBloc();
//   double _value = 1;
//
//   void setupWaitTime(ItemSkillModel data) async {
//     await Future.delayed(const Duration(seconds: 1), () {
//       setState(() {
//
//       });
//     });
//   }
//
//   @override
//   void initState() {
//     super.initState();
//
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     bloc.fetchAllSkill(pageNum: 1).catchError((e) {
//       showAlertTimeOutDialog(context, 'Alert', e.toString());
//     });
//     return StreamBuilder(
//       stream: bloc.allSkills,
//       builder: (context,AsyncSnapshot<ItemSkillModel> snapshot) {
//         if(snapshot.hasData){
//           return Scaffold(
//             appBar: AppBar(
//               title: Text('ADD SKILL'),
//               backgroundColor: AppThemes.theme_color,
//             ),
//             backgroundColor: AppThemes.theme_color,
//             body: Center(
//                 child: InkWell(
//                   child: Container(
//                     color: Colors.black,
//                     padding: EdgeInsets.all(10),
//                     child: Text('View Skills', style: AppFonts.title_style1(context)),
//                   ),
//                   onTap: () => showSearch(
//                     context: context,
//                     delegate: CustomSearchDelegate(canId)<Skill>(
//                       items: snapshot.data.skills,
//                       searchLabel: 'Search skill',
//                       suggestion: Center(
//                         child: Text('Filter skill by name'),
//                       ),
//                       failure: Center(
//                         child: Text('No skill found'),
//                       ),
//                       filter: (skill) => [skill.description],
//                       builder: (skill) => Container(
//                         color: Colors.black.withOpacity(0.3),
//                         child: ListTile(
//                           onTap: () {
//                             showDialog(
//                               context: context,
//                               builder: (BuildContext context) {
//                                 return AlertDialog(
//                                   title: Text('Add skill: ' + skill.description),
//                                   content: SliderTheme(
//                                     data: SliderTheme.of(context).copyWith(
//                                       activeTrackColor: Colors.red[700],
//                                       inactiveTrackColor: Colors.red[100],
//                                       trackShape: RoundedRectSliderTrackShape(),
//                                       trackHeight: 4.0,
//                                       thumbShape:
//                                       RoundSliderThumbShape(enabledThumbRadius: 12.0),
//                                       thumbColor: Colors.redAccent,
//                                       overlayColor: Colors.red.withAlpha(32),
//                                       overlayShape:
//                                       RoundSliderOverlayShape(overlayRadius: 28.0),
//                                       tickMarkShape: RoundSliderTickMarkShape(),
//                                       activeTickMarkColor: Colors.red[700],
//                                       inactiveTickMarkColor: Colors.red[100],
//                                       valueIndicatorShape:
//                                       PaddleSliderValueIndicatorShape(),
//                                       valueIndicatorColor: Colors.redAccent,
//                                       valueIndicatorTextStyle: TextStyle(
//                                         color: Colors.white,
//                                       ),
//                                     ),
//                                     child: Slider(
//                                       value: _value,
//                                       min: 0,
//                                       max: 5,
//                                       divisions: 1,
//                                       label: '$_value',
//                                       onChanged: (value) {
//                                         setState(
//                                               () {
//                                             _value = value;
//                                           },
//                                         );
//                                       },
//                                     ),
//                                   ),
//                                 );
//                               },
//                             );
//                           },
//                           title: Text(skill.description),
//                         ),
//                       ),
//                     ),
//                   ),
//                 )
//                 ),
//
//           );
//         }else if (snapshot.hasError) {
//           return Text(snapshot.error.toString());
//         }
//         return Center(child: CircularProgressIndicator());
//       }
//     );
//   }
// }
