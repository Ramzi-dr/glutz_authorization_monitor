import 'package:flutter/material.dart';
import 'package:glutz_authorization_monitor/widget/bottom_navigation_bar.dart';
import 'app_db.dart';
import 'glutzServer/rpc_server.dart';
import 'widget/info_card.dart';
import 'widget/style.dart';
import 'widget/textField_deco.dart';
import 'widget/widget_method.dart';

class ConfigurationScreen extends StatefulWidget {
  static const id = '/configurationScreen';
  @override
  State<ConfigurationScreen> createState() => _ConfigurationScreenState();
}

class _ConfigurationScreenState extends State<ConfigurationScreen> {
  final TextEditingController _readerController = TextEditingController();
  final TextEditingController _confirmedReaderController =
      TextEditingController();
  final TextEditingController _rpcServerUrlController = TextEditingController();
  String infoText() {
    return AppSherdDb().cloudReadReader();
  }

  changeIndex() {
    (int index) {
      setState(() {
        BottomBar.currentIndex = index;
      });
    };
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: WillPopScope(
        onWillPop: () async => false,
        child: GestureDetector(
          onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
          child: Scaffold(
            bottomNavigationBar: BottomBar(
                    changeIndex,
                    context,
                    '/callScreen',
                    '/homeScreen',
                    '/emailScreen',
                    Icons.call,
                    Icons.home,
                    Icons.email,
                    'BST Call',
                    'Home',
                    'BST Email')
                .bottomBar(),
            resizeToAvoidBottomInset: true,
            appBar: Method.appBar(),
            backgroundColor: Style.appBackgroudColor(),
            body: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 70.0),
              child: Center(
                child: SingleChildScrollView(
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: infoText().length < 5
                              ? MediaQuery.of(context).size.width / 4
                              : MediaQuery.of(context).size.width / 1.5,
                          child: InfoCardWidget(text: infoText()),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        TextFormField(
                          controller: _readerController,
                          onChanged: ((value) {}),
                          obscureText: false,
                          textAlign: TextAlign.center,
                          keyboardType: TextInputType.number,
                          decoration: TextFieldDecoration(
                              'Name des Autorisierungspunkts'),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        TextFormField(
                            controller: _confirmedReaderController,
                            onChanged: ((value) {}),
                            obscureText: false,
                            textAlign: TextAlign.center,
                            keyboardType: TextInputType.number,
                            decoration:
                                TextFieldDecoration('Namen bestätigen')),
                        const SizedBox(
                          height: 20,
                        ),
                        TextFormField(
                            controller: _rpcServerUrlController,
                            onChanged: ((value) {}),
                            obscureText: false,
                            textAlign: TextAlign.center,
                            keyboardType: TextInputType.number,
                            decoration: TextFieldDecoration('Rpc Server Url')),
                        const SizedBox(
                          height: 20,
                        ),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(25),
                          child: Stack(
                            children: <Widget>[
                              Positioned.fill(
                                child: gradientColor(),
                              ),
                              TextButton(
                                style: TextButton.styleFrom(
                                  padding: const EdgeInsets.all(16.0),
                                  // ignore: deprecated_member_use
                                  primary: Colors.white,
                                  textStyle: const TextStyle(fontSize: 20),
                                ),
                                onPressed: () {
                                  if (_confirmedReaderController.text ==
                                          _readerController.text &&
                                      _confirmedReaderController.text.length >
                                          2) {
                                    RpcServer().getDeviceIdByDeviceLabel(
                                        _readerController.text);
                                    readerLabelConfig(context);
                                  } else {
                                    Method().EntryDialog(context);
                                  }
                                },
                                child: const Text('Senden'),
                              ),
                            ],
                          ),
                        ),
                      ]),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void readerLabelConfig(BuildContext context) {
    AppSherdDb().readerCreate(_confirmedReaderController.text);
    _readerController.clear();
    _confirmedReaderController.clear();
    setState(() {
      infoText();
    });
    Navigator.pushNamed(context, '/homeScreen');
  }
}
