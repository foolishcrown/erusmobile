import 'package:erusmobile/scr/resources/authorize_token_store.dart';
import 'package:erusmobile/scr/resources/repository.dart';
import 'package:erusmobile/scr/widgets/LoadingScreen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;
final GoogleSignIn googleSignIn = GoogleSignIn();


Future<String> signInWithGoogle(BuildContext context, Key _keyLoader) async {
  await Firebase.initializeApp();

  ///GET LOGIN MAIL
  final GoogleSignInAccount googleSignInAccount = await googleSignIn.signIn();

  ///LOADING DIALOG
  Dialogs.showLoadingDialog(context, _keyLoader);

  print('Email before regist : ' + googleSignInAccount.email);

  ///CALL LOGIN REPOSITORY
  final _repository = LoginRepository();

  ///CHECK EXIST ACCOUNT
  bool checkValid = false;
  await _repository
      .fetchExistStatusAccount(email: googleSignInAccount.email)
      .then((value) => checkValid = value);

  if (checkValid) {
    ///GET AUTHENTICATION GOOGLE
    final GoogleSignInAuthentication googleSignInAuthentication =
        await googleSignInAccount.authentication;

    ///GET ACCESS TOKEN AND ID TOKEN FOR FIREBASE
    final AuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleSignInAuthentication.accessToken,
      idToken: googleSignInAuthentication.idToken,
    );

    ///SAVE ID TOKEN TO SHARED_PREFERENCE
    String idToken = googleSignInAuthentication.idToken;
    print('id Token : ' + idToken);
    await _repository.fetchAuthorizeToken(idToken: idToken).then(
        (authorizeToken) async => await SharedPrefAccount.saveString(
            SharedPrefAccount.AUTHORIZE_TOKEN, authorizeToken));

    ///CONVERT USER FROM ID TOKEN
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

      print('signInWithGoogle succeeded: ${user.email}');

      ///GET EMPLOYEE ACCOUNT FROM EMAIL, THEN SAVE TO SHARED PREFERENCE
      await _repository.fetchEmpAccount(user.email).then((empAccount) async => {
        await SharedPrefAccount.saveInt(
            SharedPrefAccount.EMP_ID, empAccount.id),
        await SharedPrefAccount.saveString(
            SharedPrefAccount.FIRST_NAME, empAccount.firstName),
        await SharedPrefAccount.saveString(
            SharedPrefAccount.LAST_NAME, empAccount.lastName),
        await SharedPrefAccount.saveString(
            SharedPrefAccount.PHONE, empAccount.phone),
        await SharedPrefAccount.saveString(
            SharedPrefAccount.ADDRESS, empAccount.address),
        await SharedPrefAccount.saveString(
            SharedPrefAccount.DATE_OF_BIRTH, empAccount.dateOfBirth),
        await SharedPrefAccount.saveInt(
            SharedPrefAccount.TOTAL_REWARD, empAccount.totalReward),
        await SharedPrefAccount.saveInt(
            SharedPrefAccount.QUANTITY_CANDIDATE,
            empAccount.quantityCandidate),
        await SharedPrefAccount.saveString(
            SharedPrefAccount.EMAIL, empAccount.email),
      }).then((value) => Navigator.pop(context)).catchError((e) {
        throw e;
      }).then((value) => null);

      return '$user';
    }
  }
  return null;
}

void signOutGoogle() async {
  await googleSignIn.signOut();

  print("User Signed Out");
}
