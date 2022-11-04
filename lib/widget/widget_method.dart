import 'package:flutter/material.dart';

import '../main.dart';

class Method {
  static AppBar appBar() {
    return AppBar(
        automaticallyImplyLeading: false,
        title: const Center(
            child: Text(
          'Door Monitor System',
          style: TextStyle(fontSize: 30),
        )),
        flexibleSpace: gradientColor());
  }

  static int selectedIndex = 1;

  // ignore: non_constant_identifier_names
  static Future<dynamic> EntryDialog(
      {title = 'Es ist ein Fehler aufgetreten',
      text = 'Bitte versuchen Sie es erneut'}) {
    return showDialog(
        context: NavigationService.navigatorKey.currentContext!,
        builder: (BuildContext context) {
          Future.delayed(
            const  Duration(seconds: 5), (() => Navigator.of(context).pop(true)));
          return Center(
            child: AlertDialog(
                title: Text(title, textAlign: TextAlign.center),
                content: TextButton(
                  child: Text(
                    text,
                    textAlign: TextAlign.center,
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                )),
          );
        });
  }

  static callDialog() {
    EntryDialog(
        text: 'please controle connection, server Url, userName and userPass');
  }
}

Container gradientColor() {
  return Container(
    decoration: const BoxDecoration(
      gradient: LinearGradient(
        colors: <Color>[
          Color.fromARGB(255, 25, 183, 19),
          Color.fromARGB(255, 38, 103, 94),
          Color.fromARGB(255, 48, 91, 93),
        ],
      ),
    ),
  );
}
