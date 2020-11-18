import 'package:erusmobile/scr/resources/authorize_token_store.dart';

class EmpAccount {
  int _id;
  String _firstName;
  String _lastName;
  String _phone;
  String _address;
  String _dateOfBirth;
  int _totalReward;
  int _quantityCandidate;
  String _email;
  String _companyId;
  String _companyName;
  String _companyAddress;
  String _companyPhone;
  int _rank;
  int _numberCandidateHired;

  int get rank => _rank;

  EmpAccount(result) {
    if (result != null) {
      _id = result['id'];
      _firstName = result['firstName'];
      _lastName = result['lastName'];
      _email = result['email'];
      _phone = result['phone'];
      _address = result['address'];
      _dateOfBirth = result['dateOfBirth'];
      _totalReward = result['totalReward'];
      _quantityCandidate = result['quantityCandidate'];
    }
  }

  EmpAccount.getRank(result){
    _rank = result['rank'];
    _numberCandidateHired = result['numberCandidate'];
    // _id = result['empId'];
  }

  Future<EmpAccount> loadFormSharedPref() async {
    await SharedPrefAccount.readIntValue(SharedPrefAccount.EMP_ID)
        .then((value) => _id = value);
    await SharedPrefAccount.readStringValue(SharedPrefAccount.FIRST_NAME)
        .then((value) => _firstName = value);
    await SharedPrefAccount.readStringValue(SharedPrefAccount.LAST_NAME)
        .then((value) => _lastName = value);
    await SharedPrefAccount.readStringValue(SharedPrefAccount.PHONE)
        .then((value) => _phone = value);
    await SharedPrefAccount.readStringValue(SharedPrefAccount.ADDRESS)
        .then((value) => _address = value);
    await SharedPrefAccount.readStringValue(SharedPrefAccount.DATE_OF_BIRTH)
        .then((value) => _dateOfBirth = value);
    await SharedPrefAccount.readStringValue(SharedPrefAccount.EMAIL)
        .then((value) => _email = value);
    await SharedPrefAccount.readIntValue(SharedPrefAccount.TOTAL_REWARD)
        .then((value) => _totalReward = value);
    await SharedPrefAccount.readIntValue(SharedPrefAccount.QUANTITY_CANDIDATE)
        .then((value) => _quantityCandidate = value);
    return this;
  }

  int get id => _id;

  String get email => _email;

  String get firstName => _firstName;

  int get quantityCandidate => _quantityCandidate;

  int get totalReward => _totalReward;

  String get dateOfBirth => _dateOfBirth;

  String get address => _address;

  String get phone => _phone;

  String get lastName => _lastName;

  String get fullName => _lastName + ' ' + firstName;

  String get companyId => _companyId;

  String get companyName => _companyName;

  String get companyAddress => _companyAddress;

  String get companyPhone => _companyPhone;

  int get numberCandidateHired => _numberCandidateHired;
}
