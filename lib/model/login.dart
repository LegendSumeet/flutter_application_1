// To parse this JSON data, do
//
//     final superadmin = superadminFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

Superadmin superadminFromJson(String str) => Superadmin.fromJson(json.decode(str));

String superadminToJson(Superadmin data) => json.encode(data.toJson());

class Superadmin {
    final String email;
    final String password;

    Superadmin({
        required this.email,
        required this.password,
    });

    factory Superadmin.fromJson(Map<String, dynamic> json) => Superadmin(
        email: json["email"],
        password: json["password"],
    );

    Map<String, dynamic> toJson() => {
        "email": email,
        "password": password,
    };
}
