// To parse this JSON data, do
//
//     final toyType = toyTypeFromJson(jsonString);

import 'dart:convert';

class ToyType {
  ToyType({
    this.type,
  });

  List<Type>? type;

  factory ToyType.fromRawJson(String str) => ToyType.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ToyType.fromJson(Map<String, dynamic> json) => ToyType(
    type: json["type"] == null ? null : List<Type>.from(json["type"].map((x) => Type.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "type": type == null ? null : List<dynamic>.from(type!.map((x) => x.toJson())),
  };
}

class Type {
  Type({
    this.title,
    this.typeId,
  });

  String? title;
  String? typeId;

  factory Type.fromRawJson(String str) => Type.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Type.fromJson(Map<String, dynamic> json) => Type(
    title: json["title"] == null ? null : json["title"],
    typeId: json["type_id"] == null ? null : json["type_id"],
  );

  Map<String, dynamic> toJson() => {
    "title": title == null ? null : title,
    "type_id": typeId == null ? null : typeId,
  };
}
