import 'package:swapy/core/base/model/base_model.dart';

class UserInfoModel extends BaseModel{
  UserInfoModel({
    this.address,
    this.userImage,
    this.phone,
    this.name,
    this.rating,
    this.email,
    this.userUid,
    this.userDeviceID
  });

  String? address;
  String? userImage;
  String? phone;
  String? name;
  double? rating;
  String? email;
  String? userUid;
  String? userDeviceID;

  fromJson(Map<String, dynamic> json) => UserInfoModel(
    address: json["address"] == null ? null : json["address"],
    userImage: json["user_image"] == null ? null : json["user_image"],
    phone: json["phone"] == null ? null : json["phone"],
    name: json["name"] == null ? null : json["name"],
    rating: json["rating"] == null ? null : json["rating"],
    email: json["email"] == null ? null : json["email"],
    userUid: json["userUid"] == null ? null : json["userUid"],
    userDeviceID: json["deviceID"] == null ? null : json["deviceID"],
  );

  Map<String, dynamic> toJson() => {
    "address": address == null ? null : address,
    "user_image": userImage == null ? null : userImage,
    "phone": phone == null ? null : phone,
    "name": name == null ? null : name,
    "rating": rating == null ? null : rating,
    "email": email == null ? null : email,
    "userUid": userUid == null ? null : userUid,
    "deviceID": userDeviceID == null ? null : userDeviceID
  };
}
