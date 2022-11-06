import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:glutz_authorization_monitor/app_db.dart';
import 'package:glutz_authorization_monitor/glutzServer/ws_collection.dart';
import 'package:glutz_authorization_monitor/hold_screen.dart';
import 'package:glutz_authorization_monitor/load_screen.dart';
import 'package:web_socket_channel/io.dart';
import '../main.dart';

class WebsocketServer with ChangeNotifier {
  var dialogCounter = 0;
  bool loadScreenIsCurrent = false;
  bool homeScreenIsCurrent = true;

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
          print('server Quit and we try to reconnect');

          screenMangerInError('server Quit and we try to reconnect');
        }
         if (data['method'] != 'aboutToQuit') {
          print(data);
          print('from: $homeScreenIsCurrent');
          if (homeScreenIsCurrent == false) {
                Navigator.pushReplacementNamed(context, '/homeScreen');

            loadScreenIsCurrent = false;
            homeScreenIsCurrent = true;
          }
        }
      }, onError: (e) {
        print('onError: $e');

        screenMangerInError(e.toString());
      });
    } catch (e) {
      print('yes: $e');
      screenMangerInError(e.toString());
    }
  }

  void screenMangerInError(title) {
    if (loadScreenIsCurrent == false) {
      Navigator.of(context).pushReplacementNamed('/loadingScreen',arguments: LoadingScreen(title));
      loadScreenIsCurrent = true;
      homeScreenIsCurrent = false;
    }

    Future.delayed(const Duration(seconds: 2), () => listenToServer());
  }
}
