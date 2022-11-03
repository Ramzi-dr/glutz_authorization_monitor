import 'dart:async';
import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/scheduler.dart';
import 'package:glutz_authorization_monitor/app_db.dart';
import 'package:glutz_authorization_monitor/glutzServer/ws_collection.dart';
import 'package:glutz_authorization_monitor/widget/widget_method.dart';
import 'package:web_socket_channel/io.dart';

class WebsocketServer with ChangeNotifier {
  var dialogCounter = 0;
  var connected = false;
  Timer? timer;
  void reconnect() {
    if (connected == false) {
      timer = Timer.periodic(const Duration(seconds: 5), (timer) {
        print(connected);
        listenToServer();
      });
    } else {
      timer?.cancel();
    }
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

          if (data['method'] == 'aboutToQuit') {
            reconnect();
          }
          if (data['method'] != 'aboutToQuit') {
           
          }
        },
        onError: (me) {
          reconnect();
          print('me: $me');
          dialogCounter++;

          if (me.toString().contains(
                  'WebSocketChannelException: WebSocketChannelException: SocketException:') &&
              dialogCounter == 20) {
            reconnect();

            Method.callDialog();
          }
          ;
        },
      );
    } catch (e) {
      print('e $e');
    }
  }
}
