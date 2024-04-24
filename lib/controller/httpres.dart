import "dart:convert";

import "package:flutter_application_1/model/login.dart";
import "package:flutter_application_1/model/statioMOdel.dart";
import "package:http/http.dart" as https;
import "package:shared_preferences/shared_preferences.dart";

import "../constant.dart";

class AuthHelper {
  static Future<bool> createStation(Superadmin model) async {
    Map<String, String> requestHeaders = {
      'Content-type': 'application/json',
      'Accept': 'application/json',
    };

    var url = Uri.parse( "https://greenchargehub.vercel.app/superuser/admin/login/${model.email}/${model.password}");

    var response = await https.get(url);

    var data = jsonDecode(response.body);
    if (response.statusCode == 200) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString("UID", data["_id"]);
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

    var url = Uri.https(
        Server.url, "/createstation/adminstation");

    var response = await https.get(url, headers: requestHeaders);

    if (response.statusCode == 200) {
      print(response.body);
      return getStationsFromJson(response.body);
    } else {
      print(response.body);
      return [];
    }
  }

  static Future<List<GetStations>> Station() async {
    Map<String, String> requestHeaders = {
      'Content-type': 'application/json',
      'Accept': 'application/json',
    };

    var url = Uri.https(
        Server.url, "/createstation/station");

    var response = await https.get(url, headers: requestHeaders);

    if (response.statusCode == 200) {
      print(response.body);
      return getStationsFromJson(response.body);
    } else {
      print(response.body);
      return [];
    }
  }
}
