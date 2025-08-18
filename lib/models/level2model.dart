import 'dart:convert';

Level2Model level2ModelFromJson(String str) =>
    Level2Model.fromJson(json.decode(str));

String level2ModelToJson(Level2Model data) => json.encode(data.toJson());

class Level2Model {
  int? success;
  String? msg;
  List<String>? levels2;

  Level2Model({
    this.success,
    this.msg,
    this.levels2,
  });

  factory Level2Model.fromJson(Map<String, dynamic> json) => Level2Model(
        success: json["success"],
        msg: json["msg"],
        levels2: json["levels2"] == null
            ? []
            : List<String>.from(json["levels2"]!.map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "msg": msg,
        "levels2":
            levels2 == null ? [] : List<dynamic>.from(levels2!.map((x) => x)),
      };
}
