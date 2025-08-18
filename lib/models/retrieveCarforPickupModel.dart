import 'dart:convert';

RetrieveCarforPickupModel retrieveCarforPickupModelFromJson(String str) =>
    RetrieveCarforPickupModel.fromJson(json.decode(str));

String retrieveCarforPickupModelToJson(RetrieveCarforPickupModel data) =>
    json.encode(data.toJson());

class RetrieveCarforPickupModel {
  int? success;
  String? msg;
  Car? car;

  RetrieveCarforPickupModel({
    this.success,
    this.msg,
    this.car,
  });

  factory RetrieveCarforPickupModel.fromJson(Map<String, dynamic> json) =>
      RetrieveCarforPickupModel(
        success: json["success"],
        msg: json["msg"],
        car: json["car"] == null ? null : Car.fromJson(json["car"]),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "msg": msg,
        "car": car?.toJson(),
      };
}

class Car {
  String? barcode;
  DateTime? admittime;
  String? parkingIp;
  String? parkedByStaff;

  Car({
    this.barcode,
    this.admittime,
    this.parkingIp,
    this.parkedByStaff,
  });

  factory Car.fromJson(Map<String, dynamic> json) => Car(
        barcode: json["barcode"],
        admittime: json["admittime"] == null
            ? null
            : DateTime.parse(json["admittime"]),
        parkingIp: json["Parking_IP"],
        parkedByStaff: json["ParkedByStaff"],
      );

  Map<String, dynamic> toJson() => {
        "barcode": barcode,
        "admittime": admittime?.toIso8601String(),
        "Parking_IP": parkingIp,
        "ParkedByStaff": parkedByStaff,
      };
}
