import 'package:flutter/material.dart';
import 'package:glutz_authorization_monitor/configuration_screen.dart';
import 'package:glutz_authorization_monitor/widget/style.dart';
import 'package:glutz_authorization_monitor/widget/widget_method.dart';

class CallScreen extends StatefulWidget {
  static const id = '/callScreen';

  @override
  State<CallScreen> createState() => _CallScreenState();
}

class _CallScreenState extends State<CallScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Method.bottomBar((
        int index,
      ) {
        setState(() {
          Method.selectedIndex = index;
          
        });
      }, 'Home', Icons.home, ('/homeScreen'), this.context),
      resizeToAvoidBottomInset: true,
      appBar: Method.appBar(),
      backgroundColor: Style.appBackgroudColor(),
      body: Scaffold(
          body: Container(
              child: Center(
                child: Text('call Screen'),
              ),
              color: Colors.redAccent)),
    );
  }
}
