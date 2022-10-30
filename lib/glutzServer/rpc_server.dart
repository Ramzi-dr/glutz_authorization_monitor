import 'package:flutter/material.dart';
import 'package:glutz_authorization_monitor/app_db.dart';
import 'package:glutz_authorization_monitor/widget/widget_method.dart';
import 'package:json_rpc_client/json_rpc_client.dart';
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
    }
  }

  getReaderLabel(userGivenText, BuildContext context) async {
    try {
      for (var readers in await getDevicesInfo(context) as List) {
        print(readers);
        //if (readers['label'] = userGivenText) {
         // print(true);
         // Navigator.pushNamed(context, '/homeScreen');
        //}
        ;
      }
    } on Exception catch (e) {
      print('this readerList $e');
      // TODO
    }
  }
}
