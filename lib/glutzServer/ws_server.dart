import 'dart:async';
import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:glutz_authorization_monitor/app_db.dart';
import 'package:glutz_authorization_monitor/glutzServer/ws_collection.dart';
import 'package:glutz_authorization_monitor/widget/widget_method.dart';
import 'package:web_socket_channel/io.dart';

class WebsocketServer with ChangeNotifier {
  Timer? timer;
  void reconnect() {
    timer = Timer.periodic(const Duration(seconds: 2), (timer) {
      listenToServer();
    });
  }

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
          print(data);
          if (data['method'] == 'aboutToQuit') {
            listenToServer();
          }
        },
        onError: (me) {
          //reconnect();
          print(me);

          if (me.toString().contains('was not upgraded to websocket')) {
            Method.EntryDialog(
                text:
                    'connection Failed please controle server Url, userName and userPass');
          }
          ;
        },
      );
    } catch (e) {
      print('e $e');
    }
  }
}
