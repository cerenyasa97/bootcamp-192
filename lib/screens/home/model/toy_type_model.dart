// To parse this JSON data, do
//
//     final toyType = toyTypeFromJson(jsonString);

import 'dart:convert';

class ToyType {
  ToyType({
    this.type,
  });

  List<TType>? type;

  factory ToyType.fromRawJson(String str) => ToyType.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ToyType.fromJson(Map<String, dynamic> json) => ToyType(
    type: json["type"] == null ? null : List<TType>.from(json["type"].map((x) => TType.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "type": type == null ? null : List<dynamic>.from(type!.map((x) => x.toJson())),
  };
}

class TType {
  TType({
    this.title,
    this.typeId,
  });

  String? title;
  String? typeId;

  factory TType.fromRawJson(String str) => TType.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory TType.fromJson(Map<String, dynamic> json) => TType(
    title: json["title"] == null ? null : json["title"],
    typeId: json["type_id"] == null ? null : json["type_id"],
  );

  Map<String, dynamic> toJson() => {
    "title": title == null ? null : title,
    "type_id": typeId == null ? null : typeId,
  };
}
