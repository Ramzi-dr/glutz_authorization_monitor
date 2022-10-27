import 'package:flutter/material.dart';
import 'package:glutz_authorization_monitor/configuration_screen.dart';
import 'package:glutz_authorization_monitor/widget/style.dart';
import 'package:glutz_authorization_monitor/widget/widget_method.dart';

class EmailScreen extends StatefulWidget {
  static const id = '/emailScreen';

  @override
  State<EmailScreen> createState() => _EmailScreenState();
}

class _EmailScreenState extends State<EmailScreen> {
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
              color: Colors.yellow,
              child: Center(
                child: Text('email Screeen'),
              ))),
    );
  }
}
