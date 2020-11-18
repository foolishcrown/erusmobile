import 'package:erusmobile/scr/blocs/candidate_skill_bloc.dart';
import 'package:erusmobile/scr/blocs/skill_bloc.dart';
import 'package:erusmobile/scr/models/skill_model.dart';
import 'package:erusmobile/scr/resources/api.dart';
import 'package:erusmobile/scr/widgets/LoadingScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_touch_spin/flutter_touch_spin.dart';
import 'AlertDialogChecker.dart';

class CustomSearchDelegate extends SearchDelegate {
  final int canId;
  final bloc = SkillBloc();
  final blocCandidateSkill = CandidateSkillBloc();
  // final GlobalKey<State> _keyLoader = new GlobalKey<State>();



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

  void setupWaitTimeResponse(
      {String successMsg,
      String failMsg,
      bool status,
      BuildContext context}) async {
    if (status) {
      Scaffold.of(context).showSnackBar(SnackBar(content: Text(successMsg)));
      await Future.delayed(const Duration(seconds: 1))
          .then((value) => {Navigator.pop(context)});
    } else {
      Scaffold.of(context).showSnackBar(SnackBar(content: Text(failMsg)));
      await Future.delayed(const Duration(seconds: 1))
          .then((value) => {Navigator.pop(context)});
    }
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

    return SingleChildScrollView(
      child: Column(
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
                    int _value = 1;
                    return ListTile(
                      onTap: () {
                        showDialog(
                            context: context,
                            builder: (context) {
                              return StatefulBuilder(
                                  builder: (context, setState) {
                                    return AlertDialog(
                                      title: Text(result.description),
                                      content: new SingleChildScrollView(
                                        child: Row(
                                          children: [
                                            Text('Select level   '),
                                            SizedBox(
                                              width: 3,
                                            ),
                                            TouchSpin(
                                              min: 1,
                                              max: 5,
                                              step: 1,
                                              value: 1,
                                              // displayFormat: NumberFormat.currency(locale: 'en_US', symbol: '\$'),
                                              textStyle: TextStyle(fontSize: 20),
                                              iconSize: 20.0,
                                              addIcon:
                                              Icon(Icons.add_circle_outline),
                                              subtractIcon:
                                              Icon(Icons.remove_circle_outline),
                                              iconActiveColor: Colors.green,
                                              iconDisabledColor: Colors.grey,
                                              iconPadding: EdgeInsets.all(20),
                                              onChanged: (val) {
                                                _value = val;
                                              },
                                            ),
                                          ],
                                        ),
                                      ),
                                      actions: <Widget>[
                                        new FlatButton(
                                          child: new Text("Cancel"),
                                          onPressed: () {
                                            Navigator.pop(context);
                                          },
                                        ),
                                        new FlatButton(
                                          child: new Text("Add"),
                                          onPressed: () {
                                            Navigator.pop(context);
                                            // Dialogs.showLoadingDialog(
                                            //     context, _keyLoader);
                                            blocCandidateSkill
                                                .addSkillCandidate(
                                                canId: this.canId,
                                                skillId: snapshot
                                                    .data.skills[index].id,
                                                level: _value)
                                                .catchError((e) {
                                              showAlertTimeOutDialog(
                                                  context, 'Alert', e.toString());
                                            });
                                            // blocCandidateSkill.addSkill.stream.first
                                            //     .then((value) => {
                                            // print('Stateeeee: ' + value.toString()),
                                            //   Navigator.pop(context),
                                            // });
                                          },
                                        ),
                                      ],
                                    );
                                  });
                            });
                      },
                      title: Row(
                        children: [
                          Text(result.description),
                        ],
                      ),
                    );
                  },
                );
              }
            },
          ),
        ],
      ),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // This method is called everytime the search term changes.
    // If you want to add search suggestions as the user enters their search term, this is the place to do that.
    return Column();
  }
}
