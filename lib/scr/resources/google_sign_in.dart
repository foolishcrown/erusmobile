import 'package:erusmobile/scr/models/emp_account_model.dart';
import 'package:erusmobile/scr/resources/authorize_token_store.dart';
import 'package:erusmobile/scr/resources/repository.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;
final GoogleSignIn googleSignIn = GoogleSignIn();


Future<String> signInWithGoogle() async {
  await Firebase.initializeApp();
  final GoogleSignInAccount googleSignInAccount = await googleSignIn.signIn();
  print('Email before regist : ' + googleSignInAccount.email);
  final _repository = LoginRepository();
  // ItemEmpAccountModel empModel =
  //     await _repository.fetchAllEmpAccounts(numpage: 1);
  // print('Account :' + empModel.toString());
  // bool checkValid = false;
  // for (int i = 0; i < empModel.accounts.length; i++) {
  //   if (empModel.accounts[i].email.toUpperCase() ==
  //       googleSignInAccount.email.toUpperCase()) {
  //     checkValid = true;
  //     break;
  //   }
  // }
  bool checkValid = false;
  await _repository.fetchExistStatusAccount(email: googleSignInAccount.email)
      .then((value) => checkValid = value);

  if (checkValid) {
    final GoogleSignInAuthentication googleSignInAuthentication =
    await googleSignInAccount.authentication;

    final AuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleSignInAuthentication.accessToken,
      idToken: googleSignInAuthentication.idToken,
    );
    String idToken =  googleSignInAuthentication.idToken;
    print('id Token : ' + idToken);
    await _repository.fetchAuthorizeToken(idToken: idToken).then(
            (authorizeToken) async =>
        await SharedPrefAccount.saveString(
            SharedPrefAccount.AUTHORIZE_TOKEN, authorizeToken));

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
          });

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
