

import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefAccount {
  static final AUTHORIZE_TOKEN = 'AuthorizeToken';
  static final EMP_ID = 'id';
  static final FIRST_NAME = 'firstName';
  static final LAST_NAME = 'lastName';
  static final PHONE = 'phone';
  static final ADDRESS = 'address';
  static final DATE_OF_BIRTH = 'dateOfBirth';
  static final TOTAL_REWARD = 'totalReward';
  static final QUANTITY_CANDIDATE = 'quantityCandidate';
  static final EMAIL = 'email';
  static final FULLNAME = 'fullname';
  static final COMPANY_ID = 'companyId';
  static saveString(String id, String value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(id, value);
  }

  static Future<String> readStringValue(String id) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    //Return String
    String stringValue = prefs.getString(id);
    return stringValue;
  }

  static saveInt(String id, int value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt(id, value);
  }

  static Future<int> readIntValue(String id) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    //Return int
    int intValue = prefs.getInt(id);
    return intValue;
  }
}