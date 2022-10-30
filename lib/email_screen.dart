import 'package:flutter/material.dart';
import 'package:glutz_authorization_monitor/configuration_screen.dart';
import 'package:glutz_authorization_monitor/widget/bottom_navigation_bar.dart';
import 'package:glutz_authorization_monitor/widget/style.dart';
import 'package:glutz_authorization_monitor/widget/widget_method.dart';

class EmailScreen extends StatefulWidget {
  static const id = '/emailScreen';

  @override
  State<EmailScreen> createState() => _EmailScreenState();
}

class _EmailScreenState extends State<EmailScreen> {
  changeIndex() {
    (int index) {
      setState(() {
        BottomBar.currentIndex = index;
      });
    };
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomBar(
              changeIndex,
              context,
              '/configurationScreen',
              '/homeScreen',
              '/callScreen',
              Icons.settings,
              Icons.home,
              Icons.call,
              'Config',
              'Home',
              'BST Call')
          .bottomBar(),
      resizeToAvoidBottomInset: true,
      appBar: Method.appBar(),
      backgroundColor: Style.appBackgroudColor(),
      body: Scaffold(
          body: Container(
        color: Colors.yellow,
        child: const Center(
            child: IconButton(
          onPressed: null,
          icon: Icon(Icons.email),
          iconSize: 200,
        )),
      )),
    );
  }
}
