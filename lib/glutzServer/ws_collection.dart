class WsCollection{
   static final data = {
    "method": "registerObserver",
    "params": [
      [
        "UsersGroups",
        "UserGroupRelations",
        "Codes",
        "Media",
        "Devices",
        "AccessPoints",
        "AuthorizationPoints",
        "AuthorizationPointRelations",
        "DeviceEvents",
        "Rights",
        "ObservedStates",
        "TimeProfiles",
        "TimeSlots",
        "DeviceStatus",
        "RouteTree",
        "Properties",
        "PropertyValueSpecs",
        "DevicePropertyData",
        "DeviceStaticPropertyData",
        "SystemPropertyData",
        "AccessPointPropertyData",
        "UserPropertyData",
        "HolidayCalendars",
        "Holidays",
        "DeviceUpdates",
        "EventLog",
        "CustomProperties",
        "Logins",
        "ActionProfiles",
        "PermissionProfiles",
        "Permissions",
        "Subsystems",
        "CustomFilesTree"
      ]
    ],
    "jsonrpc": "2.0"
  };

 static final getStatus = {
    "method": "eAccess.getModel",
    "params": [
      "DeviceStatus",
      {"deviceid": "573.556.067"}
    ],
    "id": 74,
    "jsonrpc": "2.0"
  };
}