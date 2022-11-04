import 'dart:async';
import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:glutz_authorization_monitor/app_db.dart';
import 'package:glutz_authorization_monitor/glutzServer/ws_collection.dart';
import 'package:glutz_authorization_monitor/widget/widget_method.dart';
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
      response.stream.listen(
        (event) {
          final data = jsonDecode(event);

          if (data['method'] == 'aboutToQuit') {
            Future.delayed(
                const Duration(seconds: 5), (() => listenToServer()));
            print('server Quit and we try to reconnect');
          } else {
            print(data);
            if (dialogCounter > 10) {
              Navigator.pushNamed(context, '/homeScreen');
            }
            dialogCounter = 0;
          }
        },
        onError: (me) {
          Future.delayed(const Duration(seconds: 5), (() => listenToServer()));
          print('me: $me');
          dialogCounter++;

          if (me.toString().contains(
              'WebSocketChannelException: WebSocketChannelException: SocketException:')) {
            Future.delayed(
                const Duration(seconds: 5), (() => listenToServer()));

            if (dialogCounter == 10) {
              Method.EntryDialog(text: me.toString());
            }
          }
          ;
        },
      );
    } catch (e) {
      print('e $e');
    }
  }
}
