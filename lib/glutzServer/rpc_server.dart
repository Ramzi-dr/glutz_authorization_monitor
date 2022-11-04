import 'dart:async';

import 'package:flutter/material.dart';
import 'package:glutz_authorization_monitor/app_db.dart';
import 'package:glutz_authorization_monitor/glutzServer/ws_server.dart';
import 'package:glutz_authorization_monitor/widget/widget_method.dart';
import 'package:json_rpc_client/json_rpc_client.dart';
import '../main.dart';
import 'rpc_collection.dart';

final context = NavigationService.navigatorKey.currentContext!;

class RpcServer extends ChangeNotifier {
  static const id = '/';
  var connected = false;
  var counter = 0;
  var reconnectCounter = 0;
  var dialogCounter = 0;


  void reconnect() {
    print('connected from reconnect: $connected');
    print('reconnectCounter: $reconnectCounter');
    if (connected == false) {
      Timer.periodic(const Duration(seconds: 5), (timer) {
        Future.delayed(const Duration(seconds: 5), (() {
          getDevicesInfo();
          reconnectCounter++;
          dialogCounter++;
        }));
        if (connected == true) {
          timer.cancel();
          reconnectCounter = 0;
        }
      });
    }
  }

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
        connected = true;

        myValue = value.result as List;
        print(myValue);

        print('connected: $connected');

        for (var reader in myValue) {
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
      }).timeout(const Duration(seconds: 5));
    } on Exception catch (e) {
      print('exception error: $e');
      if (e.toString().contains('Future not completed') &&
          reconnectCounter < 5 &&
          connected == false) {
        reconnect();

        if (dialogCounter < 2) {
          Method.callDialog();
          dialogCounter++;
        }
      } else {
        if (dialogCounter < 2) {
          Method.EntryDialog(text: e.toString());
          dialogCounter++;
        }
        if (reconnectCounter < 5 && connected == false) {
          reconnect();
        }
        ;
      }
    } on Error catch (e) {
      print('error error: $e');
      Method.EntryDialog(text: e.toString());
    }
  }
}
