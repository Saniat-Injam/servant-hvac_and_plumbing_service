// To parse this JSON data, do
//
//     final singleJobDetails = singleJobDetailsFromJson(jsonString);

import 'dart:convert';

SingleJobDetails singleJobDetailsFromJson(String str) => SingleJobDetails.fromJson(json.decode(str));

String singleJobDetailsToJson(SingleJobDetails data) => json.encode(data.toJson());

class SingleJobDetails {
  bool? success;
  String? message;
  Result? result;

  SingleJobDetails({
    this.success,
    this.message,
    this.result,
  });

  factory SingleJobDetails.fromJson(Map<String, dynamic> json) => SingleJobDetails(
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

  Result({
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

  factory Result.fromJson(Map<String, dynamic> json) => Result(
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
