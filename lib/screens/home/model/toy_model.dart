// To parse this JSON data, do
//
//     final toyResult = toyResultFromJson(jsonString);

import 'dart:convert';

import 'package:swapy/core/base/model/base_model.dart';

class ToyResult extends BaseModel{
    ToyResult({
        this.toys,
    });

    List<Toy>? toys;

    @override
    fromJson(Map<String, dynamic>? json) => ToyResult(
        toys: json?["toys"] == null ? null : List<Toy>.from(json!["toys"].map((x) => Toy.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "toys": toys == null ? null : List<dynamic>.from(toys!.map((x) => x.toJson())),
    };
}

class Toy {
    Toy({
        this.toyId,
        this.advertiserRating,
        this.advertiserId,
        this.advertiserImage,
        this.gender,
        this.image,
        this.advertiser,
        this.description,
        this.name,
        this.coin
    });

    String? toyId;
    double? advertiserRating;
    String? advertiserImage;
    String? advertiserId;
    String? image;
    String? advertiser;
    String? gender;
    String? description;
    String? name;
    int? coin;

    factory Toy.fromRawJson(String str) => Toy.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory Toy.fromJson(Map<String, dynamic> json) => Toy(
        toyId: json["toy_id"] == null ? null : json["toy_id"],
        advertiserRating: json["advertiser_rating"] == null ? null : json["advertiser_rating"],
        advertiserImage: json["advertiser_image"] == null ? null : json["advertiser_image"],
        advertiserId: json["advertiser_id"] == null ? null : json["advertiser_id"],
        image: json["image"] == null ? null : json["image"],
        advertiser: json["advertiser"] == null ? null : json["advertiser"],
        gender: json["gender"] == null ? null : json["gender"],
        description: json["description"] == null ? null : json["description"],
        name: json["name"] == null ? null : json["name"],
        coin: json["coin"] == null ? null : json["coin"],
    );

    Map<String, dynamic> toJson() => {
        "toy_id": toyId == null ? null : toyId,
        "advertiser_rating": advertiserRating == null ? null : advertiserRating,
        "advertiser_image": advertiserImage == null ? null : advertiserImage,
        "image": image == null ? null : image,
        "advertiser": advertiser == null ? null : advertiser,
        "advertiser_id": advertiserId == null ? null : advertiserId,
        "gender": gender == null ? null : gender,
        "description": description == null ? null : description,
        "name": name == null ? null : name,
    };
}
