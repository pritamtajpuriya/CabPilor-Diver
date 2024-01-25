// To parse this JSON data, do
//
//     final user = userFromJson(jsonString);

import 'dart:convert';

User userFromJson(String str) => User.fromJson(json.decode(str));

String userToJson(User data) => json.encode(data.toJson());

class User {
  int? id;
  String? name;
  String? email;
  dynamic emailVerifiedAt;
  DateTime? createdAt;
  DateTime? updatedAt;
  dynamic profilePic;
  String? phoneNo;
  String? address;
  int? loginType;
  String? usertype;
  int? approved;
  String? apiToken;

  User({
    this.id,
    this.name,
    this.email,
    this.emailVerifiedAt,
    this.createdAt,
    this.updatedAt,
    this.profilePic,
    this.phoneNo,
    this.address,
    this.loginType,
    this.usertype,
    this.approved,
    this.apiToken,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"],
        name: json["name"],
        email: json["email"],
        emailVerifiedAt: json["email_verified_at"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        profilePic: json["profile_pic"],
        phoneNo: json["phone_no"],
        address: json["address"],
        loginType: json["login_type"],
        usertype: json["usertype"],
        approved: json["approved"],
        apiToken: json["api_token"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "email": email,
        "email_verified_at": emailVerifiedAt,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "profile_pic": profilePic,
        "phone_no": phoneNo,
        "address": address,
        "login_type": loginType,
        "usertype": usertype,
        "approved": approved,
        "api_token": apiToken,
      };
}
