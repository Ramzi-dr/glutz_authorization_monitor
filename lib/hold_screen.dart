import 'package:glutz_authorization_monitor/app_db.dart';
import 'package:glutz_authorization_monitor/configuration_screen.dart';
import 'package:glutz_authorization_monitor/glutzServer/rpc_server.dart';
import 'package:glutz_authorization_monitor/glutzServer/ws_server.dart';
import 'package:glutz_authorization_monitor/home_screen.dart';
import 'package:flutter/material.dart';

class HoldScreen extends StatefulWidget {
  static const id = ('/');
  const HoldScreen({super.key});

  @override
  State<HoldScreen> createState() => _HoldScreenState();
}

class _HoldScreenState extends State<HoldScreen> {
  @override
  Widget build(BuildContext context) {
    if (!AppSherdDb().dbCheckValue('reader') ||
        !AppSherdDb().dbCheckValue('userName') ||
        !AppSherdDb().dbCheckValue('userPass') ||
        !AppSherdDb().dbCheckValue('serverUrl')) {
      return const ConfigurationScreen();
    } else {
      RpcServer().getDevicesInfo();
      return HomeScreen();
    }
  }
}
