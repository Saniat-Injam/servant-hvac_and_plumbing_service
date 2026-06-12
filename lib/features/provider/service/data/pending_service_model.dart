// To parse this JSON data, do
//
//     final pendingServiceModel = pendingServiceModelFromJson(jsonString);

import 'dart:convert';

List<PendingServiceModel> pendingServiceModelFromJson(String str) =>
    List<PendingServiceModel>.from(
        json.decode(str).map((x) => PendingServiceModel.fromJson(x)));

String pendingServiceModelToJson(List<PendingServiceModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class PendingServiceModel {
  String? id;
  String? serviceName;
  String? phonNumber;
  Location? location;
  String? address;
  num? price;
  List<String>? categories;
  DateTime? serviceDate;
  String? desc;
  String? serviceImage;
  String? userId;
  String? requestStatus;
  List<dynamic>? cancellBy;
  DateTime? createdAt;
  DateTime? updatedAt;
  Dist? dist;

  PendingServiceModel({
    this.id,
    this.serviceName,
    this.phonNumber,
    this.location,
    this.address,
    this.price,
    this.categories,
    this.serviceDate,
    this.desc,
    this.serviceImage,
    this.userId,
    this.requestStatus,
    this.cancellBy,
    this.createdAt,
    this.updatedAt,
    this.dist,
  });

  factory PendingServiceModel.fromJson(Map<String, dynamic> json) =>
      PendingServiceModel(
        id: json["_id"]?["\$oid"],
        serviceName: json["serviceName"],
        phonNumber: json["phonNumber"],
        location:
        json["location"] != null ? Location.fromJson(json["location"]) : null,
        address: json["address"],
        price: json["price"],
        categories: json["categories"] != null
            ? List<String>.from(json["categories"].map((x) => x))
            : [],
        serviceDate: json["serviceDate"] != null
            ? DateTime.tryParse(json["serviceDate"]["\$date"])
            : null,
        desc: json["desc"],
        serviceImage: json["serviceImage"],
        userId: json["userId"]?["\$oid"],
        requestStatus: json["requestStatus"],
        cancellBy: json["cancellBy"] ?? [],
        createdAt: json["createdAt"] != null
            ? DateTime.tryParse(json["createdAt"]["\$date"])
            : null,
        updatedAt: json["updatedAt"] != null
            ? DateTime.tryParse(json["updatedAt"]["\$date"])
            : null,
        dist: json["dist"] != null ? Dist.fromJson(json["dist"]) : null,
      );

  Map<String, dynamic> toJson() => {
    "_id": {"\$oid": id},
    "serviceName": serviceName,
    "phonNumber": phonNumber,
    "location": location?.toJson(),
    "address": address,
    "price": price,
    "categories": categories,
    "serviceDate": serviceDate?.toIso8601String(),
    "desc": desc,
    "serviceImage": serviceImage,
    "userId": {"\$oid": userId},
    "requestStatus": requestStatus,
    "cancellBy": cancellBy,
    "createdAt": createdAt?.toIso8601String(),
    "updatedAt": updatedAt?.toIso8601String(),
    "dist": dist?.toJson(),
  };
}

class Location {
  String? type;
  List<double>? coordinates;

  Location({
    this.type,
    this.coordinates,
  });

  factory Location.fromJson(Map<String, dynamic> json) => Location(
    type: json["type"],
    coordinates: json["coordinates"] != null
        ? List<double>.from(json["coordinates"].map((x) => x.toDouble()))
        : [],
  );

  Map<String, dynamic> toJson() => {
    "type": type,
    "coordinates": coordinates,
  };
}

class Dist {
  double? calculated;

  Dist({
    this.calculated,
  });

  factory Dist.fromJson(Map<String, dynamic> json) => Dist(
    calculated: json["calculated"]?.toDouble(),
  );

  Map<String, dynamic> toJson() => {
    "calculated": calculated,
  };
}
