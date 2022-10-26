import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppSherdDb with ChangeNotifier {
  static late SharedPreferences prefs;
  String reader = '';
  bool codeExist = false;
  String newCloudAddress = '';
  String newCloudKey = '';
  Future init() async {
    prefs = await SharedPreferences.getInstance();
  }

  bool valueCheck(value) {
    return prefs.containsKey(value);
  }

  readerCreate(reader) async {
    await prefs.setString('reader', reader);
  }

  codeDelete() {}

  cloudCreateAddress(cloudLink) async {
    await prefs.setString('cloudAddress', cloudLink);
    newCloudAddress = cloudLink;
    notifyListeners();
  }

  String cloudReadReader() {
    newCloudAddress = prefs.getString('reader') ?? '';
    reader = prefs.getString('reader')??'';
    notifyListeners();
    return  prefs.getString('reader') ?? '';
  }
}
