// To parse this JSON data, do
//
//     final getStations = getStationsFromJson(jsonString);

import 'dart:convert';

List<GetStations> getStationsFromJson(String str) => List<GetStations>.from(json.decode(str).map((x) => GetStations.fromJson(x)));

String getStationsToJson(List<GetStations> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class GetStations {
  String id;
  String name;
  String address;
  double price;
  double latitude;
  double longitude;
  String ownerName;
  String ownerPhone;
  String ownerEmail;
  String ownerPassword;
  bool isapproved;
  DateTime createdAt;
  DateTime updatedAt;
  int v;
  String? plugs;

  GetStations({
    required this.id,
    required this.name,
    required this.address,
    required this.price,
    required this.latitude,
    required this.longitude,
    required this.ownerName,
    required this.ownerPhone,
    required this.ownerEmail,
    required this.ownerPassword,
    required this.isapproved,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
    this.plugs,
  });

  factory GetStations.fromJson(Map<String, dynamic> json) => GetStations(
    id: json["_id"],
    name: json["name"],
    address: json["address"],
    price: json["price"]?.toDouble(),
    latitude: json["latitude"]?.toDouble(),
    longitude: json["longitude"]?.toDouble(),
    ownerName: json["ownerName"],
    ownerPhone: json["ownerPhone"],
    ownerEmail: json["ownerEmail"],
    ownerPassword: json["ownerPassword"],
    isapproved: json["isapproved"],
    createdAt: DateTime.parse(json["createdAt"]),
    updatedAt: DateTime.parse(json["updatedAt"]),
    v: json["__v"],
    plugs: json["plugs"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "name": name,
    "address": address,
    "price": price,
    "latitude": latitude,
    "longitude": longitude,
    "ownerName": ownerName,
    "ownerPhone": ownerPhone,
    "ownerEmail": ownerEmail,
    "ownerPassword": ownerPassword,
    "isapproved": isapproved,
    "createdAt": createdAt.toIso8601String(),
    "updatedAt": updatedAt.toIso8601String(),
    "__v": v,
    "plugs": plugs,
  };
}
