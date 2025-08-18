import 'dart:convert';

Level3Model level3ModelFromJson(String str) =>
    Level3Model.fromJson(json.decode(str));

String level3ModelToJson(Level3Model data) => json.encode(data.toJson());

class Level3Model {
  int? success;
  String? msg;
  List<String>? levels3;

  Level3Model({
    this.success,
    this.msg,
    this.levels3,
  });

  factory Level3Model.fromJson(Map<String, dynamic> json) => Level3Model(
        success: json["success"],
        msg: json["msg"],
        levels3: json["levels3"] == null
            ? []
            : List<String>.from(json["levels3"]!.map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "msg": msg,
        "levels3":
            levels3 == null ? [] : List<dynamic>.from(levels3!.map((x) => x)),
      };
}
