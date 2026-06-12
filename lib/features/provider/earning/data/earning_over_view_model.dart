import 'dart:convert';

EarningOverviewModel earningOverviewModelFromJson(String str) =>
    EarningOverviewModel.fromJson(json.decode(str));

String earningOverviewModelToJson(EarningOverviewModel data) =>
    json.encode(data.toJson());

class EarningOverviewModel {
  bool success;
  String message;
  Result result;

  EarningOverviewModel({
    required this.success,
    required this.message,
    required this.result,
  });

  factory EarningOverviewModel.fromJson(Map<String, dynamic> json) =>
      EarningOverviewModel(
        success: json["success"],
        message: json["message"],
        result: Result.fromJson(json["result"]),
      );

  Map<String, dynamic> toJson() => {
    "success": success,
    "message": message,
    "result": result.toJson(),
  };
}

class Result {
  double totalRevenue;
  List<Weekly> weekly;

  Result({
    required this.totalRevenue,
    required this.weekly,
  });

  factory Result.fromJson(Map<String, dynamic> json) => Result(
    totalRevenue: (json["totalRevenue"] as num).toDouble(),
    weekly:
    List<Weekly>.from(json["weekly"].map((x) => Weekly.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "totalRevenue": totalRevenue,
    "weekly": List<dynamic>.from(weekly.map((x) => x.toJson())),
  };
}

class Weekly {
  String day;
  double total;

  Weekly({
    required this.day,
    required this.total,
  });

  factory Weekly.fromJson(Map<String, dynamic> json) => Weekly(
    day: json["day"],
    total: (json["total"] as num).toDouble(),
  );

  Map<String, dynamic> toJson() => {
    "day": day,
    "total": total,
  };
}
