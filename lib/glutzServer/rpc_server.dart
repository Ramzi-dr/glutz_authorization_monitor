import 'package:flutter/material.dart';
import 'package:glutz_authorization_monitor/widget/widget_method.dart';
import 'package:json_rpc_client/json_rpc_client.dart';
import 'rpc_collection.dart';
import 'dart:convert';

const demoUrl = 'http://admin:admin@31.24.10.138:8332/rpc/';

class RpcServer extends ChangeNotifier {
  final client = JRPCHttpClient(Uri.parse(demoUrl));
  static const id = '/';
  String deviceLabel = '';
  String deviceid = '';
  String userLabel = '';
  String badgeId = '';

  Future getDevicesInfo() async {
    Object? myValue;
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
      print(e);
      // TODOdd
    }
  }

  getReaderLabel(userGivenText) async {
    print(userGivenText);
    for (var readers in await getDevicesInfo() as List) {
      if (readers['label'] == userGivenText) {
        print(true);
      }
      ;
    }
  }
}
