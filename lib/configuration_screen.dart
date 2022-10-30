import 'package:flutter/material.dart';
import 'package:glutz_authorization_monitor/widget/bottom_navigation_bar.dart';
import 'package:glutz_authorization_monitor/widget/text_field.dart';
import 'package:provider/provider.dart';
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
  final TextEditingController _rpcServerUrlController = TextEditingController();
  final TextEditingController _userNameController = TextEditingController();
  final TextEditingController _userPassController = TextEditingController();

  String infoText() {
    return AppSherdDb().dbSearchData('reader');
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
              padding: const EdgeInsets.symmetric(horizontal: 30.0),
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
                        MyTextField(
                            controller: _readerController,
                            textLabel: 'Access Point Name',
                            obscureText: false),
                        const SizedBox(
                          height: 20,
                        ),
                        MyTextField(
                            controller: _userNameController,
                            textLabel: 'Server User',
                            obscureText: false),
                        const SizedBox(
                          height: 20,
                        ),
                        MyTextField(
                          controller: _userPassController,
                          textLabel: 'user Pass',
                          obscureText: false,
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        MyTextField(
                            controller: _rpcServerUrlController,
                            textLabel: 'Rpc Server Url',
                            obscureText: false),
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
                                   RpcServer().getReaderLabel(_readerController.text);
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
    AppSherdDb().dbCreateReader(_readerController.text);
    _readerController.clear();
    setState(() {
      infoText();
    });
    Navigator.pushNamed(context, '/homeScreen');
  }
}
