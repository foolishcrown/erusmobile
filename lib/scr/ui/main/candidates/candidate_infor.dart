import 'dart:io';

import 'package:erusmobile/constrants/app_constrants.dart';
import 'package:erusmobile/scr/blocs/candidate_bloc.dart';
import 'package:erusmobile/scr/models/candidate_model.dart';
import 'package:erusmobile/scr/resources/file_picker.dart';
import 'package:erusmobile/scr/widgets/AlertDialogChecker.dart';
import 'package:erusmobile/scr/widgets/LoadFilePDF.dart';
import 'package:erusmobile/scr/widgets/LoadingScreen.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class CandidateInfo extends StatefulWidget {
  String title;
  final bool isCreate;
  final int candidateId;
  final int empId;

  CandidateInfo(
      {@required this.isCreate, this.candidateId, @required this.empId});

  @override
  _CandidateInfoState createState() => _CandidateInfoState();
}

class _CandidateInfoState extends State<CandidateInfo> {
  final sizeSpace2 = 10.0;

  @override
  Widget build(BuildContext context) {
    var routeCandidate;

    ///NEW CANDIDATE
    if (widget.isCreate) {
      widget.title = 'New Candidate';
      routeCandidate = CandidateRoutePage(
        isCreate: widget.isCreate,
        empId: widget.empId,
      );

      ///EDIT CANDIDATE
    } else {
      widget.title = 'Edit Candidate';
      routeCandidate = CandidateRoutePage(
        isCreate: widget.isCreate,
        candidateId: widget.candidateId,
        empId: widget.empId,
      );
    }

    return Scaffold(
        resizeToAvoidBottomPadding: false,
        appBar: AppBar(
          backgroundColor: AppThemes.theme_color,
          title: Text(widget.title),
          actions: <Widget>[],
        ),
        body: routeCandidate);
  }
}

// ignore: must_be_immutable
class CandidateRoutePage extends StatefulWidget {
  bool isCreate;
  int candidateId;
  int empId;

  CandidateRoutePage({this.isCreate, this.candidateId, this.empId});

  @override
  _CandidateRoutePageState createState() => _CandidateRoutePageState();
}

class _CandidateRoutePageState extends State<CandidateRoutePage> {
  final bloc = CandidateBloc();
  final GlobalKey<State> _keyLoader = new GlobalKey<State>();
  final _formKey = GlobalKey<FormState>();
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _emailController = TextEditingController();
  final _resumeFileController = TextEditingController();
  bool isSubmit = false;
  bool isSelectFile = false;
  String selectFileMsg = 'Please select resume file!';
  File selectedFile;

  void _onSelectFile() {
    setState(() {
      selectFileMsg = 'Selected!';
      isSelectFile = true;
    });
  }

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _phoneController.dispose();
    _emailController.dispose();
    _resumeFileController.dispose();
    super.dispose();
  }

  void setupWaitTimeResponse(
      {String successMsg, String failMsg, bool status}) async {
    if (status) {
      Scaffold.of(context).showSnackBar(SnackBar(content: Text(successMsg)));
      await Future.delayed(const Duration(seconds: 1))
          .then((value) => {Navigator.pop(context), Navigator.pop(context)});
    } else {
      Scaffold.of(context).showSnackBar(SnackBar(content: Text(failMsg)));
      await Future.delayed(const Duration(seconds: 1))
          .then((value) => {Navigator.pop(context), Navigator.pop(context)});
    }
  }

  @override
  Widget build(BuildContext context) {
    if (widget.isCreate) {
      ///Create new candidate
      return new InkWell(
        splashColor: Colors.transparent,
        child: Form(
          key: _formKey,
          child: Container(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: <Widget>[
                // SizedBox(height: _animation.value),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: TextFormField(
                    keyboardType: TextInputType.name,
                    controller: _firstNameController,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    decoration: InputDecoration(
                      labelText: 'First name',
                      icon: Icon(Icons.drive_file_rename_outline),
                    ),
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Please enter some text';
                      }
                      return null;
                    },
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: TextFormField(
                    keyboardType: TextInputType.name,
                    controller: _lastNameController,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    decoration: InputDecoration(
                      labelText: 'Last name',
                      icon: Icon(Icons.drive_file_rename_outline),
                    ),
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Please enter some text';
                      }
                      return null;
                    },
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: TextFormField(
                    keyboardType: TextInputType.phone,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    controller: _phoneController,
                    decoration: InputDecoration(
                      labelText: 'Phone',
                      icon: Icon(Icons.phone),
                    ),
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Please enter phone';
                      }
                      if (value.length > 13) {
                        return 'Phone must < 13 numbers';
                      }
                      return null;
                    },
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: TextFormField(
                    keyboardType: TextInputType.emailAddress,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    controller: _emailController,
                    decoration: InputDecoration(
                      labelText: 'Email',
                      icon: Icon(Icons.email),
                    ),
                    validator: (value) {
                      Pattern pattern =
                          r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]"
                          r"{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]"
                          r"{0,253}[a-zA-Z0-9])?)*$";
                      RegExp regex = new RegExp(pattern);
                      if (value.isEmpty) {
                        return 'Please enter email';
                      } else if (!regex.hasMatch(value))
                        return 'Please enter a valid email address';
                      return null;
                    },
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: Row(
                    children: [
                      InkWell(
                        onTap: () {
                          pickFileChooser().then((value) => {
                                if (value is File)
                                  {
                                    // FireStorageService.saveToStorage(value)
                                    _resumeFileController.text =
                                        value.path.split('/').last,
                                    print("Selected File : " +
                                        _resumeFileController.text),
                                    selectedFile = value,
                                    isSelectFile = true,
                                    // _resumeFileController.text = value.
                                    _onSelectFile(),
                                  }
                                else
                                  {print('Cancel upload')}
                              });
                        },
                        child: Container(
                          padding: EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            borderRadius:
                                BorderRadius.all(Radius.circular(5.0)),
                            color: Colors.deepOrangeAccent.withOpacity(0.3),
                          ),
                          // color: Colors.orangeAccent.withOpacity(0.2),
                          child: Row(
                            children: [
                              Icon(
                                Icons.picture_as_pdf,
                                size: 30,
                                color: Colors.redAccent,
                              ),
                              Text('Add Resume File')
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width / 40,
                      ),
                      Text(
                        selectFileMsg,
                        style: AppFonts.comp_style_detail_red(context),
                      ),
                    ],
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    // Validate returns true if the form is valid, or false
                    // otherwise.
                    if (!isSubmit) {
                      if (_formKey.currentState.validate() && isSelectFile) {
                        // If the form is valid, display a Snackbar.
                        Dialogs.showLoadingDialog(context, _keyLoader);
                        String firstName = _firstNameController.text;
                        String lastName = _lastNameController.text;
                        String phone = _phoneController.text;
                        String email = _emailController.text;
                        String resumeFile = _resumeFileController.text;
                        Candidate _tmpCandidate = Candidate.newCandidate(
                            firstName: firstName,
                            lastName: lastName,
                            phone: phone,
                            email: email,
                            resuneFile: resumeFile);
                        bloc.insertCandidate(
                            empId: widget.empId, candidate: _tmpCandidate);
                        bloc.insertStatus.stream.first.then((value) => {
                              if (value)
                                {
                                  FireStorageService.saveToStorage(
                                      selectedFile, resumeFile)
                                },
                              setupWaitTimeResponse(
                                  successMsg: 'Create Success',
                                  failMsg: 'Create Fail',
                                  status: value),
                            });
                      }
                    }
                  },
                  child: Text('Create'),
                ),
              ],
            ),
          ),
        ),
      );
    } else {
      bloc.fetchCandidateById(canId: widget.candidateId).catchError((e) {
        showAlertTimeOutDialog(context, 'Alert', e.toString());
      });

      ///Edit candidate
      return StreamBuilder<Candidate>(
          stream: bloc.candidateInfo,
          builder: (context, AsyncSnapshot<Candidate> snapshot) {
            if (snapshot.hasData) {
              _firstNameController.text = snapshot.data.firstName;
              _lastNameController.text = snapshot.data.lastName;
              _phoneController.text = snapshot.data.phone;
              _emailController.text = snapshot.data.email;

              return new InkWell(
                splashColor: Colors.transparent,
                child: Form(
                  key: _formKey,
                  child: Container(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      children: <Widget>[
                        // SizedBox(height: _animation.value),
                        Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 20, vertical: 10),
                          child: TextFormField(
                            controller: _firstNameController,
                            keyboardType: TextInputType.name,
                            autovalidateMode:
                            AutovalidateMode.onUserInteraction,
                            decoration: InputDecoration(
                              labelText: 'First name',
                              icon: Icon(Icons.drive_file_rename_outline),
                            ),
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'Please enter some text';
                              }
                              return null;
                            },
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 20, vertical: 10),
                          child: TextFormField(
                            controller: _lastNameController,
                            keyboardType: TextInputType.name,
                            autovalidateMode:
                            AutovalidateMode.onUserInteraction,
                            decoration: InputDecoration(
                              labelText: 'Last name',
                              icon: Icon(Icons.drive_file_rename_outline),
                            ),
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'Please enter some text';
                              }
                              return null;
                            },
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 20, vertical: 10),
                          child: TextFormField(
                            keyboardType: TextInputType.phone,
                            autovalidateMode:
                            AutovalidateMode.onUserInteraction,
                            decoration: InputDecoration(
                              labelText: 'Phone',
                              icon: Icon(Icons.phone),
                            ),
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'Please enter some text';
                              }
                              if (value.length > 13) {
                                return 'Phone must < 13 numbers';
                              }
                              return null;
                            },
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 20, vertical: 10),
                          child: TextFormField(
                            keyboardType: TextInputType.emailAddress,
                            autovalidateMode:
                            AutovalidateMode.onUserInteraction,
                            controller: _emailController,
                            decoration: InputDecoration(
                              labelText: 'Email',
                              icon: Icon(Icons.email),
                            ),
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'Please enter some text';
                              }
                              return null;
                            },
                          ),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            if (!isSubmit) {
                              if (_formKey.currentState.validate()) {
                                showDialog(
                                    context: context,
                                    builder: (context) {
                                      return AlertDialog(
                                        title: Text('Message'),
                                        content: new SingleChildScrollView(
                                          child: Text('You want to update ?'),
                                        ),
                                        actions: <Widget>[
                                          new FlatButton(
                                            child: new Text("Yes"),
                                            onPressed: () {
                                              Navigator.pop(context);

                                              ///Loading dialog
                                              Dialogs.showLoadingDialog(
                                                  context, _keyLoader);
                                              isSubmit = true;
                                              // If the form is valid, display a Snackbar.
                                              String firstName =
                                                  _firstNameController.text;
                                              String lastName =
                                                  _lastNameController.text;
                                              String phone =
                                                  _phoneController.text;
                                              String email =
                                                  _emailController.text;
                                              String resumeFile =
                                                  snapshot.data.resumeFile;
                                              Candidate _tmpCandidate =
                                              Candidate(
                                                  widget.candidateId,
                                                  firstName,
                                                  lastName,
                                                  email,
                                                  phone,
                                                  resumeFile);
                                              bloc.updateCandidateById(
                                                  empId: widget.empId,
                                                  candidate: _tmpCandidate);
                                              bloc.updateStatus.stream.first
                                                  .then(
                                                    (value) =>
                                                    setupWaitTimeResponse(
                                                        successMsg:
                                                        'Update Success',
                                                        failMsg: 'Update Fail',
                                                        status: value),
                                                // }
                                              );
                                            },
                                          ),
                                          new FlatButton(
                                            child: new Text("No"),
                                            onPressed: () {
                                              Navigator.pop(context);
                                            },
                                          ),
                                        ],
                                      );
                                    });
                              }
                            }
                            // Validate returns true if the form is valid, or false
                            // otherwise.
                          },
                          child: Text('Update'),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            } else if (snapshot.hasError) {
              return Text(snapshot.error.toString());
            }
            return Center(child: CircularProgressIndicator());
          });
    }
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
