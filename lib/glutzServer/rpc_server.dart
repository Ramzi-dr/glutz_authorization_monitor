import 'package:flutter/material.dart';
import 'package:glutz_authorization_monitor/app_db.dart';
import 'package:glutz_authorization_monitor/home_screen.dart';
import 'package:glutz_authorization_monitor/widget/widget_method.dart';
import 'package:json_rpc_client/json_rpc_client.dart';
import '../main.dart';
import 'rpc_collection.dart';

class RpcServer extends ChangeNotifier {
  static const id = '/';

  Future getDevicesInfo(BuildContext context) async {
    Object? myValue;
    const rpcPort = 8332;
    final serverIp = AppSherdDb().dbSearchData('serverUrl');
    final rpcUser = AppSherdDb().dbSearchData('userName');
    final rpcPass = AppSherdDb().dbSearchData('userPass');
    final serverUrl = 'http://$rpcUser:$rpcPass@$serverIp:$rpcPort/rpc/';
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
      Method.EntryDialog(context, text: e.toString());
    } on Error catch (e) {
      Method.EntryDialog(context, text: e.toString());
    }
  }

  getReaderLabel(userGivenText, BuildContext context) async {
    int counter = 0;
    try {
      final List readersList = await getDevicesInfo(context);
      for (var reader in readersList) {
        if (reader.containsValue(userGivenText)) {
          // ignore: use_build_context_synchronously
          Navigator.pushNamed(context, '/homeScreen');
          return;
        } else {
          counter++;

          if (readersList.length == counter) {
            // ignore: use_build_context_synchronously
            Method.EntryDialog(context, text: 'Reader dont exist');
          }
        }
      }
    } on Exception catch (e) {
      Method.EntryDialog(context, text: e.toString());
    } on TypeError catch (e) {
      Method.EntryDialog(context, text: e.toString());
    }
  }
}
