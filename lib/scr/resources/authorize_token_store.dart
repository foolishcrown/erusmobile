

import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefAccount {
  static final AUTHORIZE_TOKEN = 'AuthorizeToken';

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


}