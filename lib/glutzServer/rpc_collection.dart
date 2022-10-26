class RpcCollection {
  static String id = '10';
  static String jsonrpc = '2.0';
  static String getModel = "eAccess.getModel";
  static List params = [
                "Devices",
                {},
                [
                    "id",
                    "label",
                    "deviceid",
                    "accessPointId",
                    
                ]
            ];
}
