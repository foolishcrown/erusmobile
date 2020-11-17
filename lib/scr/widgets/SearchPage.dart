import 'dart:async';

import 'package:erusmobile/scr/blocs/skill_bloc.dart';
import 'package:erusmobile/scr/models/skill_model.dart';
import 'package:erusmobile/scr/widgets/LoadingScreen.dart';
import 'package:flutter/material.dart';
import 'package:spinner_input/spinner_input.dart';

import 'AlertDialogChecker.dart';

class CustomSearchDelegate extends SearchDelegate {
  final int canId;
  final bloc = SkillBloc();
  final GlobalKey<State> _keyLoader = new GlobalKey<State>();

  CustomSearchDelegate(this.canId);


  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    if (query.length < 1) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Center(
            child: Text(
              "Search term must be longer than 1 letter.",
            ),
          )
        ],
      );
    }

    //Add the search term to the searchBloc.
    //The Bloc will then handle the searching and add the results to the searchResults stream.
    //This is the equivalent of submitting the search term to whatever search service you are using
    bloc.fetchAllSkill(pageNum: 1).catchError((e) {
      showAlertTimeOutDialog(context, 'Alert', e.toString());
    });

    return Column(
      children: <Widget>[
        //Build the results based on the searchResults stream in the searchBloc
        StreamBuilder(
          stream: bloc.allSkills,
          builder: (context, AsyncSnapshot<ItemSkillModel> snapshot) {
            if (!snapshot.hasData) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Center(child: CircularProgressIndicator()),
                ],
              );
            } else if (snapshot.data.skills.length == 0) {
              return Column(
                children: <Widget>[
                  Text(
                    "No Skill Found.",
                  ),
                ],
              );
            } else {
              var results = snapshot.data.skills;
              return ListView.builder(
                itemCount: results.length,
                shrinkWrap: true,
                physics: ScrollPhysics(),
                itemBuilder: (context, index) {
                  var result = results[index];
                  double _value = 1;
                  return ListTile(
                    onTap: () {
                      // showDialog(
                      //     context: context,
                      //     builder: (context) {
                      //       return StatefulBuilder(
                      //         builder: (context, setState){
                      //           return AlertDialog(
                      //           title: Text(result.description),
                      //           content: new SingleChildScrollView(
                      //             child: Row(
                      //               children: [
                      //                 Text('Please select level   '),
                      //                 SizedBox(width: 3,),
                      //
                      //               ],
                      //             ),
                      //           ),
                      //           actions: <Widget>[
                      //             new FlatButton(
                      //               child: new Text("Cancel"),
                      //               onPressed: () {
                      //                 Navigator.pop(context);
                      //               },
                      //             ),
                      //             new FlatButton(
                      //               child: new Text("Add"),
                      //               onPressed: () {
                      //                 Navigator.pop(context);
                      //                 Dialogs.showLoadingDialog(
                      //                     context, _keyLoader);
                      //               },
                      //             ),
                      //           ],
                      //         );
                      //         }
                      //       );
                      //     });
                    },
                    title: Row(
                      children: [
                        Text(result.description),
                        SpinnerInput(

                            spinnerValue: _value,
                            minValue: 1,
                            maxValue: 5,
                            onChange: (newValue) {
                              _value = newValue;
                            })
                      ],
                    ),
                  );
                },
              );
            }
          },
        ),
      ],
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // This method is called everytime the search term changes.
    // If you want to add search suggestions as the user enters their search term, this is the place to do that.
    return Column();
  }
}
