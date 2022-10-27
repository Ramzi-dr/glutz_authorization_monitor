import 'package:flutter/material.dart';
import 'package:glutz_authorization_monitor/configuration_screen.dart';
import 'package:glutz_authorization_monitor/widget/style.dart';
import 'package:glutz_authorization_monitor/widget/widget_method.dart';

class HomeScreen extends StatefulWidget {
  static const id = '/homeScreen';

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Method.bottomBar((
        int index,
      ) {
        setState(() {
          Method.selectedIndex = index;
        });
        
      }, 'Config', Icons.settings,'/configurationScreen', this.context),
      resizeToAvoidBottomInset: true,
      appBar: Method.appBar(),
      backgroundColor: Style.appBackgroudColor(),
      body: Container(color: Colors.greenAccent),
    );
  }
}
