import 'package:flutter/material.dart';
import 'package:glutz_authorization_monitor/configuration_screen.dart';
import 'package:glutz_authorization_monitor/widget/bottom_navigation_bar.dart';
import 'package:glutz_authorization_monitor/widget/style.dart';
import 'package:glutz_authorization_monitor/widget/widget_method.dart';

class HomeScreen extends StatefulWidget {
  static const id = '/homeScreen';

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
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
              '/callScreen',
              '/configurationScreen',
              '/emailScreen',
              Icons.call,
              Icons.settings,
              Icons.email,
              'BST Call',
              'Config',
              'BST Email')
          .bottomBar(),
      resizeToAvoidBottomInset: true,
      appBar: Method.appBar(),
      backgroundColor: Style.appBackgroudColor(),
      body: Container(
        color: Colors.greenAccent,
        child: const Center(
            child: IconButton(
          onPressed: null,
          icon: Icon(Icons.home),
          iconSize: 200,
        )),
      ),
    );
  }
}
