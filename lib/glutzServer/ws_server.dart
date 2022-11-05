import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:glutz_authorization_monitor/app_db.dart';
import 'package:glutz_authorization_monitor/glutzServer/ws_collection.dart';
import 'package:glutz_authorization_monitor/load_screen.dart';
import 'package:web_socket_channel/io.dart';

import '../main.dart';

class WebsocketServer with ChangeNotifier {
  var dialogCounter = 0;
  var connected = false;
  final context = NavigationService.navigatorKey.currentContext!;
  listenToServer() async {
    final serverIpPort = AppSherdDb().dbSearchData('serverUrl');
    final serverUser = AppSherdDb().dbSearchData('userName');
    final serverPass = AppSherdDb().dbSearchData('userPass');
    final webSocketServerUrl = 'ws://$serverUser:$serverPass@$serverIpPort';
    try {
      final channel = IOWebSocketChannel.connect(Uri.parse(webSocketServerUrl));
      channel.sink.add(jsonEncode(WsCollection.data));
      final response = channel.cast();
      response.stream.listen((event) {
        final data = jsonDecode(event);

        if (data['method'] == 'aboutToQuit') {
          Future.delayed(const Duration(seconds: 5), () => listenToServer());
          print('server Quit and we try to reconnect');
          Navigator.pushNamed(context, '/loadingScreen');
        } else {
          print(data);
          Navigator.pushReplacementNamed(context, '/homeScreen');
        }
      }, onError: (e) {
        print('onError: $e');
        Future.delayed(const Duration(seconds: 2), () => listenToServer());
      });
    } catch (e) {
      print('yes: $e');
    }
  }
}
