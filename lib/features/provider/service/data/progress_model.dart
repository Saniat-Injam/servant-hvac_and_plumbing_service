// To parse this JSON data, do
//
//     final progressServiceModel = progressServiceModelFromJson(jsonString);

import 'dart:convert';

ProgressServiceModel progressServiceModelFromJson(String str) => ProgressServiceModel.fromJson(json.decode(str));

String progressServiceModelToJson(ProgressServiceModel data) => json.encode(data.toJson());

class ProgressServiceModel {
  bool? success;
  String? message;
  Result? result;

  ProgressServiceModel({
    this.success,
    this.message,
    this.result,
  });

  factory ProgressServiceModel.fromJson(Map<String, dynamic> json) => ProgressServiceModel(
    success: json["success"],
    message: json["message"],
    result: json["result"] == null ? null : Result.fromJson(json["result"]),
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "message": message,
    "result": result?.toJson(),
  };
}

class Result {
  Meta? meta;
  List<Datum>? data;

  Result({
    this.meta,
    this.data,
  });

  factory Result.fromJson(Map<String, dynamic> json) => Result(
    meta: json["meta"] == null ? null : Meta.fromJson(json["meta"]),
    data: json["data"] == null ? [] : List<Datum>.from(json["data"]!.map((x) => Datum.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "meta": meta?.toJson(),
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class Datum {
  String? id;
  String? serviceName;
  String? serviceImage;
  Location? location;
  DateTime? serviceDate;
  int? price;
  List<String>? categories;
  String? desc;
  String? requestStatus;
  String? address;

  Datum({
    this.id,
    this.serviceName,
    this.serviceImage,
    this.location,
    this.serviceDate,
    this.price,
    this.categories,
    this.desc,
    this.requestStatus,
    this.address,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["id"],
    serviceName: json["serviceName"],
    serviceImage: json["serviceImage"],
    location: json["location"] == null ? null : Location.fromJson(json["location"]),
    serviceDate: json["serviceDate"] == null ? null : DateTime.parse(json["serviceDate"]),
    price: json["price"],
    categories: json["categories"] == null ? [] : List<String>.from(json["categories"]!.map((x) => x)),
    desc: json["desc"],
    requestStatus: json["requestStatus"],
    address: json["address"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "serviceName": serviceName,
    "serviceImage": serviceImage,
    "location": location?.toJson(),
    "serviceDate": serviceDate?.toIso8601String(),
    "price": price,
    "categories": categories == null ? [] : List<dynamic>.from(categories!.map((x) => x)),
    "desc": desc,
    "requestStatus": requestStatus,
    "address": address,
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
    coordinates: json["coordinates"] == null ? [] : List<double>.from(json["coordinates"]!.map((x) => x?.toDouble())),
  );

  Map<String, dynamic> toJson() => {
    "type": type,
    "coordinates": coordinates == null ? [] : List<dynamic>.from(coordinates!.map((x) => x)),
  };
}

class Meta {
  int? total;
  int? page;
  int? limit;
  int? totalPages;

  Meta({
    this.total,
    this.page,
    this.limit,
    this.totalPages,
  });

  factory Meta.fromJson(Map<String, dynamic> json) => Meta(
    total: json["total"],
    page: json["page"],
    limit: json["limit"],
    totalPages: json["totalPages"],
  );

  Map<String, dynamic> toJson() => {
    "total": total,
    "page": page,
    "limit": limit,
    "totalPages": totalPages,
  };
}
