import 'dart:convert';

import 'package:http/http.dart' as http;

final String serverURL = 'http://10.196.27.87:8000/api';

Map<String, String> API = {
  "deviceData": "/get_devices/",
  "updateDevice": "/update_device/",
  "deleteDevice": "/delete_device/",
};

Future<dynamic> fetchDeviceData() async {
  var url = serverURL + API['deviceData']!;
  var res = await http.get(Uri.parse(url));
  var json = jsonDecode(res.body);
  return json["devices"];
}

Future<dynamic> updateDevice(String id, String type, int days, int hrs,
    int mins, int qty, String qty_units) async {
  var url = serverURL + API['updateDevice']!;
  Map<String, dynamic> params = {
    "id": id,
    "type": type,
    "days": days.toString(),
    "hours": hrs.toString(),
    "minutes": mins.toString(),
    "qty": qty.toString(),
    "qty_used": "0",
    "qty_units": qty_units
  };
  var res = await http.post(Uri.parse(url), body: params);
  var json = jsonDecode(res.body);
  print(json["status"]);
  return json["status"];
}

Future<dynamic> updateQty(
    String id, double qty, double qtyUsed, String qtyUnits) async {
  var url = serverURL + API['updateDevice']!;
  Map<String, String> params = {
    "id": id,
    "type": "",
    "days": "-1",
    "hours": "-1",
    "minutes": "-1",
    "qty": qty.toString(),
    "qty_used": qtyUsed.toString(),
    "qty_units": qtyUnits
  };
  var res = await http.post(Uri.parse(url), body: params);
  var json = jsonDecode(res.body);
  print(json["status"]);
  return json["status"];
}

Future<dynamic> updateTime(String id, int days, int hrs, int mins) async {
  var url = serverURL + API['updateDevice']!;
  Map<String, dynamic> params = {
    "id": id,
    "type": "",
    "days": days.toString(),
    "hours": hrs.toString(),
    "minutes": mins.toString(),
    "qty": "-1",
    "qty_used": "-1",
    "qty_units": ""
  };
  var res = await http.post(Uri.parse(url), body: params);
  var json = jsonDecode(res.body);
  print(json["status"]);
  return json["status"];
}

Future<dynamic> updateName(String id, String type) async {
  var url = serverURL + API['updateDevice']!;
  Map<String, dynamic> params = {
    "id": id,
    "type": type,
    "days": "-1",
    "hours": "-1",
    "minutes": "-1",
    "qty": "-1",
    "qty_used": "-1",
    "qty_units": ""
  };
  var res = await http.post(Uri.parse(url), body: params);
  var json = jsonDecode(res.body);
  print(json["status"]);
  return json["status"];
}

Future<dynamic> deleteDevice(String id) async {
  var url = serverURL + API['deleteDevice']!;
  Map<String, dynamic> params = {
    "id": id,
  };
  var res = await http.post(Uri.parse(url), body: params);
  var json = jsonDecode(res.body);
  print(json["status"]);
  return json["status"];
}


