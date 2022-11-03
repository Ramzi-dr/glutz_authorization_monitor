import 'package:flutter/material.dart';
import 'package:glutz_authorization_monitor/app_db.dart';
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

  final infoText = 'please do this';
  final halloUser = 'Hallo user';

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
        child: Column(
          children: [
            const SizedBox(
              height: 20,
            ),
            Text(AppSherdDb().dbSearchData('reader'),
                style: const TextStyle(fontSize: 20)),
            Expanded(
              flex: 2,
              child: Center(
                  child: SizedBox(
                child: Card(
                  color: Colors.transparent,
                  elevation: 5,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(10, 2, 10, 2),
                    child: Center(
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width - 10,
                        child: FittedBox(
                          fit: BoxFit.contain,
                          child: Text(
                            infoText,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              )),
            ),
          ],
        ),
      ),
    );
  }
}
