// To parse this JSON data, do
//
//     final notificationModel = notificationModelFromJson(jsonString);

import 'dart:convert';

NotificationModel notificationModelFromJson(String str) => NotificationModel.fromJson(json.decode(str));

String notificationModelToJson(NotificationModel data) => json.encode(data.toJson());

class NotificationModel {
  bool? success;
  String? message;
  List<Result>? result;

  NotificationModel({
    this.success,
    this.message,
    this.result,
  });

  factory NotificationModel.fromJson(Map<String, dynamic> json) => NotificationModel(
    success: json["success"],
    message: json["message"],
    result: json["result"] == null ? [] : List<Result>.from(json["result"]!.map((x) => Result.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "message": message,
    "result": result == null ? [] : List<dynamic>.from(result!.map((x) => x.toJson())),
  };
}

class Result {
  String? id;
  String? receiverId;
  String? body;
  String? title;
  DateTime? createdAt;
  DateTime? updatedAt;

  Result({
    this.id,
    this.receiverId,
    this.body,
    this.title,
    this.createdAt,
    this.updatedAt,
  });

  factory Result.fromJson(Map<String, dynamic> json) => Result(
    id: json["id"],
    receiverId: json["receiverId"],
    body: json["body"],
    title: json["title"],
    createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
    updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "receiverId": receiverId,
    "body": body,
    "title": title,
    "createdAt": createdAt?.toIso8601String(),
    "updatedAt": updatedAt?.toIso8601String(),
  };
}
