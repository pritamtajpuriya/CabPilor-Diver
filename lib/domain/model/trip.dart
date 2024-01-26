// To parse this JSON data, do
//
//     final trip = tripFromJson(jsonString);

import 'dart:convert';

import 'package:readmock/domain/model/user.dart';

List<Trip> tripFromJson(String str) =>
    List<Trip>.from(json.decode(str).map((x) => Trip.fromJson(x)));

String tripToJson(List<Trip> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Trip {
  int? tripId;
  int? tripStatus;
  TripClass? trip;

  Trip({
    this.tripId,
    this.trip,
    this.tripStatus,
  });

  Trip copyWith({
    int? tripStatus,
  }) {
    return Trip(
      tripStatus: tripStatus ?? this.tripStatus,
    );
  }

  factory Trip.fromJson(Map<String, dynamic> json) => Trip(
        tripId: json["trip_id"],
        tripStatus: json["trip_status"],
        trip: json["trip"] == null ? null : TripClass.fromJson(json["trip"]),
      );

  Map<String, dynamic> toJson() => {
        "trip_id": tripId,
        "trip": trip?.toJson(),
      };
}

class TripClass {
  int? id;
  int? userId;
  String? from;
  String? to;
  String? distance;
  String? bookDate;
  String? tripType;
  String? transType;
  String? carType;
  String? estUsage;
  String? isCpSecured;
  String? driverType;
  dynamic couponId;
  dynamic couponName;
  dynamic couponPrice;
  String? totalPrice;
  String? gTotalPrice;
  String? pickLat;
  String? pickLng;
  String? dropLat;
  String? dropLng;
  DateTime? createdAt;
  DateTime? updatedAt;
  User? user;

  TripClass({
    this.id,
    this.userId,
    this.from,
    this.to,
    this.distance,
    this.bookDate,
    this.tripType,
    this.transType,
    this.carType,
    this.estUsage,
    this.isCpSecured,
    this.driverType,
    this.couponId,
    this.couponName,
    this.couponPrice,
    this.totalPrice,
    this.gTotalPrice,
    this.pickLat,
    this.pickLng,
    this.dropLat,
    this.dropLng,
    this.createdAt,
    this.updatedAt,
    this.user,
  });

  factory TripClass.fromJson(Map<String, dynamic> json) => TripClass(
        id: json["id"],
        userId: json["user_id"],
        from: json["from"],
        to: json["to"],
        distance: json["distance"],
        bookDate: json["book_date"],
        tripType: json["trip_type"],
        transType: json["trans_type"],
        carType: json["car_type"],
        estUsage: json["est_usage"],
        isCpSecured: json["is_cp_secured"],
        driverType: json["driver_type"],
        couponId: json["coupon_id"],
        couponName: json["coupon_name"],
        couponPrice: json["coupon_price"],
        totalPrice: json["total_price"],
        gTotalPrice: json["g_total_price"],
        pickLat: json["pick_lat"],
        pickLng: json["pick_lng"],
        dropLat: json["drop_lat"],
        dropLng: json["drop_lng"],
        user: json["user"] == null ? null : User.fromJson(json["user"]),
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "from": from,
        "to": to,
        "distance": distance,
        "book_date": bookDate,
        "trip_type": tripType,
        "trans_type": transType,
        "car_type": carType,
        "est_usage": estUsage,
        "is_cp_secured": isCpSecured,
        "driver_type": driverType,
        "coupon_id": couponId,
        "coupon_name": couponName,
        "coupon_price": couponPrice,
        "total_price": totalPrice,
        "g_total_price": gTotalPrice,
        "pick_lat": pickLat,
        "pick_lng": pickLng,
        "drop_lat": dropLat,
        "drop_lng": dropLng,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
      };
}
