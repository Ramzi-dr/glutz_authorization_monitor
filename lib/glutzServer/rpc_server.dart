import 'package:flutter/material.dart';
import 'package:json_rpc_client/json_rpc_client.dart';
import 'rpc_collection.dart';

const demoUrl = 'http://admin:admin@31.24.10.138:8332/rpc/';

class RpcServer extends ChangeNotifier {
  
  final client = JRPCHttpClient(Uri.parse(demoUrl));
  static const id = '/';
  String deviceLabel = '';
  String deviceid = '';
  String userLabel = '';
  String badgeId = '';

  Future<void> getDeviceIdByDeviceLabel(userEnteredDeviceLabel) async {
    try {
      final res = await client.callRPCv2(JRPC2Request(
        id: client.nextId,
        method: RpcCollection.getModel,
        params: RpcCollection.params,
      ));
      final List response = res.result as List;
      for (var result in response) {
        print(result);
      }
    } on Exception catch (e) {
      print(e);
      // TODO
    }
  }
}
