// To parse this JSON data, do
//
//     final order = orderFromJson(jsonString);

import 'dart:convert';

import 'package:readmock/domain/model/user.dart';

BookingOrder orderFromJson(String str) =>
    BookingOrder.fromJson(json.decode(str));

String orderToJson(BookingOrder data) => json.encode(data.toJson());

class BookingOrder {
  String? distance;
  String? driverType;
  String? totalPrice;
  String? dropLng;
  DateTime? createdAt;
  String? bookDate;
  dynamic couponName;
  String? carType;
  String? isCpSecured;
  String? tripType;
  String? pickLat;
  String? dropLat;
  String? estUsage;
  dynamic couponId;
  DateTime? updatedAt;
  int? userId;
  String? pickLng;
  String? gTotalPrice;
  dynamic couponPrice;
  String? from;
  int? id;
  String? to;
  User? user;
  String? transType;

  BookingOrder({
    this.distance,
    this.driverType,
    this.totalPrice,
    this.dropLng,
    this.createdAt,
    this.bookDate,
    this.couponName,
    this.carType,
    this.isCpSecured,
    this.tripType,
    this.pickLat,
    this.dropLat,
    this.estUsage,
    this.couponId,
    this.updatedAt,
    this.userId,
    this.pickLng,
    this.gTotalPrice,
    this.couponPrice,
    this.from,
    this.id,
    this.to,
    this.user,
    this.transType,
  });

  factory BookingOrder.fromJson(Map<String, dynamic> json) => BookingOrder(
        distance: json["distance"],
        driverType: json["driver_type"],
        totalPrice: json["total_price"],
        dropLng: json["drop_lng"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        bookDate: json["book_date"],
        couponName: json["coupon_name"],
        carType: json["car_type"],
        isCpSecured: json["is_cp_secured"],
        tripType: json["trip_type"],
        pickLat: json["pick_lat"],
        dropLat: json["drop_lat"],
        estUsage: json["est_usage"],
        couponId: json["coupon_id"],
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        userId: json["user_id"],
        pickLng: json["pick_lng"],
        gTotalPrice: json["g_total_price"],
        couponPrice: json["coupon_price"],
        from: json["from"],
        id: json["id"],
        to: json["to"],
        user: json["user"] == null ? null : User.fromJson(json["user"]),
        transType: json["trans_type"],
      );

  Map<String, dynamic> toJson() => {
        "distance": distance,
        "driver_type": driverType,
        "total_price": totalPrice,
        "drop_lng": dropLng,
        "created_at": createdAt?.toIso8601String(),
        "book_date": bookDate,
        "coupon_name": couponName,
        "car_type": carType,
        "is_cp_secured": isCpSecured,
        "trip_type": tripType,
        "pick_lat": pickLat,
        "drop_lat": dropLat,
        "est_usage": estUsage,
        "coupon_id": couponId,
        "updated_at": updatedAt?.toIso8601String(),
        "user_id": userId,
        "pick_lng": pickLng,
        "g_total_price": gTotalPrice,
        "coupon_price": couponPrice,
        "from": from,
        "id": id,
        "to": to,
        "user": user?.toJson(),
        "trans_type": transType,
      };
}
