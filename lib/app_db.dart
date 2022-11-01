import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppSherdDb with ChangeNotifier {
  static late SharedPreferences prefs;

  Future init() async {
    prefs = await SharedPreferences.getInstance();
  }

  bool dbCheckValue(value) {
    return   prefs.containsKey(value);
  }

  dbCreateReader(reader) async {
    await prefs.setString('reader', reader);
  }

  dbCreateUserName(userName) async {
    await prefs.setString('userName', userName);
  }
  dbCreateUserPass(userPass) async {
    await prefs.setString('userPass', userPass);
  }
  dbCreateServerUrl(serverUrl) async {
    await prefs.setString('serverUrl', serverUrl);
  }

   dbSearchData(dataToSearch) {
     return prefs.getString(dataToSearch) ?? '';
  }
}
