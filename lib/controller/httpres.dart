import "dart:convert";

import "package:flutter_application_1/model/login.dart";
import "package:flutter_application_1/model/statioMOdel.dart";
import "package:http/http.dart" as http;
import "package:shared_preferences/shared_preferences.dart";

class AuthHelper {
  static var client = http.Client();

  static Future<bool> createStation(Superadmin model) async {
    Map<String, String> requestHeaders = {
      'Content-type': 'application/json',
      'Accept': 'application/json',
    };

    var url = Uri.http(
        "16.171.199.244:5001", "/superuser/admin/login/${model.email}/${model.password}");

    var response = await client.get(url,
        headers: requestHeaders);

    var data = jsonDecode(response.body);

    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("UID",data["_id"]);

    if (response.statusCode == 200) {
      print(response.body);
      return true;
    } else {
      print(response.body);
      return false;
    }
  }

  static Future<List<GetStations>> getStation() async {
    Map<String, String> requestHeaders = {
      'Content-type': 'application/json',
      'Accept': 'application/json',
    };

    var url = Uri.http(
        "16.171.199.244:5001", "/createstation/station");

    var response = await client.get(url,
        headers: requestHeaders);

    if (response.statusCode == 200) {
      print(response.body);
      return getStationsFromJson(response.body);
    } else {
      print(response.body);
      return [];
    }
  }
}