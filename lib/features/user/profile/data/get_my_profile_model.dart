// To parse this JSON data, do
//
//     final getMyProfile = getMyProfileFromJson(jsonString);

import 'dart:convert';

GetMyProfile getMyProfileFromJson(String str) => GetMyProfile.fromJson(json.decode(str));

String getMyProfileToJson(GetMyProfile data) => json.encode(data.toJson());

class GetMyProfile {
  bool? success;
  String? message;
  Result? result;

  GetMyProfile({
    this.success,
    this.message,
    this.result,
  });

  factory GetMyProfile.fromJson(Map<String, dynamic> json) => GetMyProfile(
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
  String? fullName;
  String? email;
  String? profileImage;
  String? coverPhoto;
  dynamic gender;
  String? userId;
  dynamic license;
  String? nid;
  List<String>? speciality;
  String? address;
  Location? location;
  DateTime? createdAt;
  DateTime? updatedAt;
  double? long;
  double? lat;

  Result({
    this.id,
    this.fullName,
    this.email,
    this.profileImage,
    this.coverPhoto,
    this.gender,
    this.userId,
    this.license,
    this.nid,
    this.speciality,
    this.address,
    this.location,
    this.createdAt,
    this.updatedAt,
    this.long,
    this.lat,
  });

  factory Result.fromJson(Map<String, dynamic> json) => Result(
    id: json["id"],
    fullName: json["fullName"],
    email: json["email"],
    profileImage: json["profileImage"],
    coverPhoto: json["coverPhoto"],
    gender: json["gender"],
    userId: json["userId"],
    license: json["license"],
    nid: json["nid"],
    speciality: json["speciality"] == null ? [] : List<String>.from(json["speciality"]!.map((x) => x)),
    address: json["address"],
    location: json["location"] == null ? null : Location.fromJson(json["location"]),
    createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
    updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
    long: json["long"]?.toDouble(),
    lat: json["lat"]?.toDouble(),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "fullName": fullName,
    "email": email,
    "profileImage": profileImage,
    "coverPhoto": coverPhoto,
    "gender": gender,
    "userId": userId,
    "license": license,
    "nid": nid,
    "speciality": speciality == null ? [] : List<dynamic>.from(speciality!.map((x) => x)),
    "address": address,
    "location": location?.toJson(),
    "createdAt": createdAt?.toIso8601String(),
    "updatedAt": updatedAt?.toIso8601String(),
    "long": long,
    "lat": lat,
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
