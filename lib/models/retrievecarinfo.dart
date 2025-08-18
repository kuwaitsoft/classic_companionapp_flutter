import 'dart:convert';

RetrieveCarInfo retrieveCarInfoFromJson(String str) =>
    RetrieveCarInfo.fromJson(json.decode(str));

String retrieveCarInfoToJson(RetrieveCarInfo data) =>
    json.encode(data.toJson());

class RetrieveCarInfo {
  int? success;
  String? msg;
  Car? car;
  List<String>? levels;

  RetrieveCarInfo({
    this.success,
    this.msg,
    this.car,
    this.levels,
  });

  factory RetrieveCarInfo.fromJson(Map<String, dynamic> json) =>
      RetrieveCarInfo(
        success: json["success"] as int?,
        msg: json["msg"] as String?,
        car: json["car"] != null ? Car.fromJson(json["car"]) : null,
        levels: json["levels"] != null
            ? List<String>.from(json["levels"].map((x) => x.toString()))
            : [],
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "msg": msg,
        "car": car?.toJson(),
        "levels":
            levels != null ? List<dynamic>.from(levels!.map((x) => x)) : [],
      };
}

class Car {
  String? barcode;
  String? keytag;
  DateTime? admittime;

  Car({
    this.barcode,
    this.keytag,
    this.admittime,
  });

  factory Car.fromJson(Map<String, dynamic> json) => Car(
        barcode: json["barcode"] as String?,
        keytag: json["keytag"] as String?,
        admittime: json["admittime"] != null
            ? DateTime.tryParse(json["admittime"])
            : null,
      );

  Map<String, dynamic> toJson() => {
        "barcode": barcode,
        "keytag": keytag,
        "admittime": admittime?.toIso8601String(),
      };
}
