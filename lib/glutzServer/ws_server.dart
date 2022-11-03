import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:glutz_authorization_monitor/app_db.dart';
import 'package:glutz_authorization_monitor/glutzServer/ws_collection.dart';
import 'package:web_socket_channel/io.dart';

class WebsocketServer with ChangeNotifier {
  listenToServer() async {
    final serverIpPort = AppSherdDb().dbSearchData('serverUrl');
    final serverUser = AppSherdDb().dbSearchData('userName');
    final serverPass = AppSherdDb().dbSearchData('userPass');
    final webSocketServerUrl = 'ws://$serverUser:$serverPass@$serverIpPort';
    try {
      final _channel =
          IOWebSocketChannel.connect(Uri.parse(webSocketServerUrl));
      _channel.sink.add(jsonEncode(WsCollection.data));
      final response = _channel.cast();
      response.stream.listen((event) {
        print(event);
      });
    } catch (e) {
      print(e);
    }
    ;
  }
}
