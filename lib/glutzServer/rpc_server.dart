import 'package:flutter/material.dart';
import 'package:glutz_authorization_monitor/app_db.dart';
import 'package:glutz_authorization_monitor/widget/widget_method.dart';
import 'package:json_rpc_client/json_rpc_client.dart';
import '../main.dart';
import 'rpc_collection.dart';

class RpcServer extends ChangeNotifier {
  static const id = '/';

  final context = NavigationService.navigatorKey.currentContext!;

  Future getDevicesInfo() async {
    Object? myValue;
    final serverIpPort = AppSherdDb().dbSearchData('serverUrl');
    final rpcUser = AppSherdDb().dbSearchData('userName');
    final rpcPass = AppSherdDb().dbSearchData('userPass');
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

  getReaderLabel() async {
    final readerInDB = AppSherdDb().dbSearchData('reader');

    int counter = 0;
    try {
      final List readersList = await getDevicesInfo();
      for (var reader in readersList) {
        if (reader.containsValue(readerInDB)) {
          AppSherdDb().dbCreateReaderDeviceId(reader['deviceid']);

          // ignore: use_build_context_synchronously
          Navigator.pushNamed(context, '/homeScreen');
        }

        if (!reader.containsValue(readerInDB)) {
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
