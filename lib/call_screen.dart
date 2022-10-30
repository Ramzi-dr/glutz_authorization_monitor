import 'package:flutter/material.dart';
import 'package:glutz_authorization_monitor/configuration_screen.dart';
import 'package:glutz_authorization_monitor/widget/bottom_navigation_bar.dart';
import 'package:glutz_authorization_monitor/widget/style.dart';
import 'package:glutz_authorization_monitor/widget/widget_method.dart';

class CallScreen extends StatefulWidget {
  static const id = '/callScreen';

  @override
  State<CallScreen> createState() => _CallScreenState();
}

class _CallScreenState extends State<CallScreen> {
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
              '/emailScreen',
              Icons.settings,
              Icons.home,
              Icons.email,
              'Config',
              'Home',
              'BST Email')
          .bottomBar(),
      resizeToAvoidBottomInset: true,
      appBar: Method.appBar(),
      backgroundColor: Style.appBackgroudColor(),
      body: Scaffold(
          body: Container(
              color: Colors.redAccent,
              child: const Center(
                  child: IconButton(
                onPressed: null,
                icon: Icon(Icons.call),
                iconSize: 200,
              )))),
    );
  }
}
