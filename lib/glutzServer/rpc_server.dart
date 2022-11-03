import 'dart:async';

import 'package:flutter/material.dart';
import 'package:glutz_authorization_monitor/app_db.dart';
import 'package:glutz_authorization_monitor/glutzServer/ws_server.dart';
import 'package:glutz_authorization_monitor/widget/widget_method.dart';
import 'package:json_rpc_client/json_rpc_client.dart';
import '../main.dart';
import 'rpc_collection.dart';

class RpcServer extends ChangeNotifier {
  static const id = '/';
  void callMethodWhenError(e) {
    print('e: $e');
    print(dialogCounter);
    if (e.toString().contains('Connection refused') ||
        e.toString().contains('TimeoutException')) {
      dialogCounter++;
      reconnect();

      if (dialogCounter == 10) {
        Method.callDialog();
        dialogCounter++;
      }
    }
  }

  var counter = 0;
  var dialogCounter = 0;
  Timer? timer;
  void reconnect() {
    timer = Timer.periodic(const Duration(seconds: 5), (timer) {
      getDevicesInfo();
    });
  }

  final context = NavigationService.navigatorKey.currentContext!;

  Future getDevicesInfo() async {
    List myValue;
    final serverIpPort = AppSherdDb().dbSearchData('serverUrl');
    final rpcUser = AppSherdDb().dbSearchData('userName');
    final rpcPass = AppSherdDb().dbSearchData('userPass');
    final readerInDB = AppSherdDb().dbSearchData('reader');
    final serverUrl = 'http://$rpcUser:$rpcPass@$serverIpPort/rpc/';
    final client = JRPCHttpClient(Uri.parse(serverUrl));

    try {
      await client
          .callRPCv2(JRPC2Request(
        id: client.nextId,
        method: RpcCollection.getModel,
        params: RpcCollection.params,
      ))
          .then((value) {
        dialogCounter = 0;
        myValue = value.result as List;

        try {
          for (var reader in myValue) {
            timer?.cancel();
            if (reader.containsValue(readerInDB)) {
              AppSherdDb().dbCreateReaderDeviceId(reader['deviceid']);

              // ignore: use_build_context_synchronously
              Navigator.pushNamed(context, '/homeScreen');
              WebsocketServer().listenToServer();
            }

            if (!reader.containsValue(readerInDB)) {
              counter++;
              if (myValue.length == counter) {
                Method.EntryDialog(text: 'Reader dont exist');
              }
            }
          }
        } on Exception catch (e) {
          callMethodWhenError(e);
        }
      }).timeout(const Duration(seconds: 5));
    } on Exception catch (e) {
      callMethodWhenError(e);
    } on Error catch (e) {
      Method.EntryDialog(text: e.toString());
    }
  }
}
