import 'package:swapy/core/base/model/base_model.dart';

class UserInfoModel extends BaseModel{
  UserInfoModel({
    this.address,
    this.city,
    this.userImage,
    this.phone,
    this.surname,
    this.district,
    this.name,
    this.rating,
    this.email,
    this.userUid,
  });

  String? address;
  String? city;
  String? userImage;
  String? phone;
  String? surname;
  String? district;
  String? name;
  double? rating;
  String? email;
  String? userUid;

  fromJson(Map<String, dynamic> json) => UserInfoModel(
    address: json["address"] == null ? null : json["address"],
    city: json["city"] == null ? null : json["city"],
    userImage: json["user_image"] == null ? null : json["user_image"],
    phone: json["phone"] == null ? null : json["phone"],
    surname: json["surname"] == null ? null : json["surname"],
    district: json["district"] == null ? null : json["district"],
    name: json["name"] == null ? null : json["name"],
    rating: json["rating"] == null ? null : json["rating"],
    email: json["email"] == null ? null : json["email"],
    userUid: json["userUid"] == null ? null : json["userUid"],
  );

  Map<String, dynamic> toJson() => {
    "address": address == null ? null : address,
    "city": city == null ? null : city,
    "user_image": userImage == null ? null : userImage,
    "phone": phone == null ? null : phone,
    "surname": surname == null ? null : surname,
    "district": district == null ? null : district,
    "name": name == null ? null : name,
    "rating": rating == null ? null : rating,
    "email": email == null ? null : email,
    "userUid": userUid == null ? null : userUid,
  };
}
