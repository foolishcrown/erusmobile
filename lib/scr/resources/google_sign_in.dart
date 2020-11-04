import 'package:erusmobile/scr/blocs/emp_account_bloc.dart';
import 'package:erusmobile/scr/models/emp_account_model.dart';
import 'package:erusmobile/scr/resources/repository.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_sign_in/google_sign_in.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;
final GoogleSignIn googleSignIn = GoogleSignIn();

String name;
String email;
String imageUrl;

Future<String> signInWithGoogle() async {
  await Firebase.initializeApp();
  final GoogleSignInAccount googleSignInAccount = await googleSignIn.signIn();
  print('Email before regist : ' + googleSignInAccount.email);
  final _repository = Repository();
  ItemEmpAccountModel empModel =
      await _repository.fetchAllEmpAccounts(numpage: 1);
  print('Account :' + empModel.toString());
  bool checkValid = false;
  for (int i = 0; i < empModel.accounts.length; i++) {
    if (empModel.accounts[i].email.toUpperCase() == googleSignInAccount.email.toUpperCase()) {
      checkValid = true;
      break;
    }
  }

  if(checkValid){
    final GoogleSignInAuthentication googleSignInAuthentication =
    await googleSignInAccount.authentication;

    final AuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleSignInAuthentication.accessToken,
      idToken: googleSignInAuthentication.idToken,
    );
    // print('ID token :' +  googleSignInAuthentication.accessToken);
    //
    // print('ID token :' +  googleSignInAuthentication.idToken);
    final UserCredential authResult =
    await _auth.signInWithCredential(credential);
    final User user = authResult.user;

    if (user != null) {
      assert(!user.isAnonymous);
      assert(await user.getIdToken() != null);

      final User currentUser = _auth.currentUser;
      assert(user.uid == currentUser.uid);

      assert(user.email != null);
      assert(user.displayName != null);
      assert(user.photoURL != null);
      // Store the retrieved data

      print('signInWithGoogle succeeded: $user');

      return '$user';
    }
  }
  print('Email ko hop le');
  return null;
}

void signOutGoogle() async {
  await googleSignIn.signOut();

  print("User Signed Out");
}
