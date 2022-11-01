
import 'package:flutter/material.dart';
import 'package:glutz_authorization_monitor/app_db.dart';
import 'package:glutz_authorization_monitor/home_screen.dart';
import 'package:glutz_authorization_monitor/widget/widget_method.dart';
import 'package:json_rpc_client/json_rpc_client.dart';
import '../main.dart';
import 'rpc_collection.dart';

class RpcServer extends ChangeNotifier {
  static const id = '/';

<<<<<<< HEAD
  final context = navigatorKey.currentContext!;
=======
>>>>>>> 5f91d4a13c71eacfa8ffbded4ce74914b5405e02
  Future getDevicesInfo() async {
    Object? myValue;
    final serverIpPort = AppSherdDb().dbSearchData('serverUrl');
    final rpcUser = AppSherdDb().dbSearchData('userName');
    final rpcPass = AppSherdDb().dbSearchData('userPass');
    final serverUrl = 'http://$rpcUser:$rpcPass@$serverIpPort/rpc/';
    print('serverUrl: $serverUrl');
    final client = JRPCHttpClient(Uri.parse(serverUrl));
    try {
      await client
          .callRPCv2(JRPC2Request(
        id: client.nextId,
        method: RpcCollection.getModel,
        params: RpcCollection.params,
      ))
          .then((value) {
        myValue = value.result;
        return value.result;
      });
      return myValue;
    } on Exception catch (e) {
      Method.EntryDialog(text: e.toString());
    } on Error catch (e) {
      Method.EntryDialog(text: e.toString());
    }
  }

<<<<<<< HEAD
  getReaderLabel() async {
    final readerInDB = AppSherdDb().dbSearchData('reader');
=======
  getReaderLabel(
    userGivenText,
  ) async {
>>>>>>> 5f91d4a13c71eacfa8ffbded4ce74914b5405e02
    int counter = 0;
    try {
      final List readersList = await getDevicesInfo();
      for (var reader in readersList) {
<<<<<<< HEAD
        if (reader.containsValue(readerInDB)) {
          // ignore: use_build_context_synchronously
          Navigator.pushNamed(context, '/homeScreen');
=======
        if (reader.containsValue(userGivenText)) {
          Navigator.pushNamed(navigatorKey.currentContext!, '/homeScreen');
>>>>>>> 5f91d4a13c71eacfa8ffbded4ce74914b5405e02
          return;
        } else {
          counter++;

          if (readersList.length == counter) {
            Method.EntryDialog(text: 'Reader dont exist');
          }
        }
      }
    } on Exception catch (e) {
      Method.EntryDialog(text: e.toString());
    } on TypeError catch (e) {
      Method.EntryDialog(text: e.toString());
    }
  }
}
