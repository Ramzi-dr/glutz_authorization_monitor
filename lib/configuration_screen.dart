import 'package:flutter/material.dart';
import 'package:glutz_authorization_monitor/widget/bottom_navigation_bar.dart';
import 'package:glutz_authorization_monitor/widget/text_field.dart';
import 'app_db.dart';
import 'glutzServer/rpc_server.dart';
import 'widget/info_card.dart';
import 'widget/style.dart';
import 'widget/widget_method.dart';

class ConfigurationScreen extends StatefulWidget {
  static const id = '/configurationScreen';

  const ConfigurationScreen({super.key});
  @override
  State<ConfigurationScreen> createState() => _ConfigurationScreenState();
}

class _ConfigurationScreenState extends State<ConfigurationScreen> {
  final TextEditingController _readerController = TextEditingController();
  final TextEditingController _serverUrlController = TextEditingController();
  final TextEditingController _userNameController = TextEditingController();
  final TextEditingController _userPassController = TextEditingController();

  String serverUrlText() {
    return AppSherdDb().dbSearchData('serverUrl');
  }

  String readerText() {
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
                          width: MediaQuery.of(context).size.width / 1.25,
                          child: InfoCardWidget(
                            serverUrlText: serverUrlText(),
                            readerText: readerText(),
                          ),
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
                            textLabel: 'User Name',
                            obscureText: false),
                        const SizedBox(
                          height: 20,
                        ),
                        MyTextField(
                          controller: _userPassController,
                          textLabel: 'User Pass',
                          obscureText: false,
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        MyTextField(
                            controller: _serverUrlController,
                            textLabel: 'Server Url',
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
                                  if (_readerController.text.length > 3) {
                                    AppSherdDb()
                                        .dbCreateReader(_readerController.text);

                                    RpcServer().getReaderLabel(
                                        _readerController.text, context);
                                    readerLabelInfo(context);
                                  } else if (_userNameController.text.length >
                                      2) {
                                    AppSherdDb().dbCreateUserName(
                                        _userNameController.text);

                                    RpcServer().getReaderLabel(
                                        _readerController.text, context);
                                  } else if (_userPassController.text.length >
                                      2) {
                                    AppSherdDb().dbCreateUserPass(
                                        _userPassController.text);

                                    RpcServer().getReaderLabel(
                                        _readerController.text, context);
                                  } else if (_serverUrlController.text.length >
                                      2) {
                                    AppSherdDb().dbCreateServerUrl(
                                        _serverUrlController.text);

                                    RpcServer().getReaderLabel(
                                        _readerController.text, context);
                                    serverUrlLabelInfo(context);
                                  } else {
                                    Method.EntryDialog(context);
                                  }
                                  clearTextField();
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

  void readerLabelInfo(BuildContext context) {
    setState(() {
      readerText();
    });
    clearTextField();
  }

  void serverUrlLabelInfo(BuildContext context) {
    setState(() {
      serverUrlText();
    });
    clearTextField();
  }

  void clearTextField() {
    _readerController.clear();
    _serverUrlController.clear();
   // _userNameController.clear();
    _userPassController.clear();
  }
}
