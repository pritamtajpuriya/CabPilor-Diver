// To parse this JSON data, do
//
//     final booklet = bookletFromJson(jsonString);

import 'dart:convert';

import 'package:readmock/domain/model/user.dart';

Booklet bookletFromJson(String str) => Booklet.fromJson(json.decode(str));

String bookletToJson(Booklet data) => json.encode(data.toJson());

class Booklet {
  int? id;
  String? bookletNumber;
  dynamic approvedBy;
  String? todaysRate;
  DateTime? orderDate;
  String? billingRate;
  int? quantity;
  DateTime? offerValidity;
  String? deliveryAddress;
  String? vehicle;
  String? remarks;
  String? paymentTermType;
  String? noOfDays;
  int? paymenttermId;
  dynamic customerId;
  int? userId;
  int? saleofficerId;
  int? companyId;

  User? user;
  DateTime? dateEn;
  DateTime? dateNp;
  String? status;
  int? createdBy;
  dynamic updatedBy;
  dynamic deletedBy;
  dynamic deletedAt;
  DateTime? createdAt;
  DateTime? updatedAt;

  Booklet({
    this.id,
    this.bookletNumber,
    this.approvedBy,
    this.todaysRate,
    this.orderDate,
    this.billingRate,
    this.quantity,
    this.offerValidity,
    this.deliveryAddress,
    this.vehicle,
    this.remarks,
    this.paymentTermType,
    this.noOfDays,
    this.paymenttermId,
    this.customerId,
    this.userId,
    this.saleofficerId,
    this.companyId,
    this.dateEn,
    this.user,
    this.dateNp,
    this.status,
    this.createdBy,
    this.updatedBy,
    this.deletedBy,
    this.deletedAt,
    this.createdAt,
    this.updatedAt,
  });

  factory Booklet.fromJson(Map<String, dynamic> json) => Booklet(
        id: json["id"],
        bookletNumber: json["booklet_number"],
        approvedBy: json["approved_by"],
        todaysRate: json["todays_rate"],
        orderDate: json["order_date"] == null
            ? null
            : DateTime.parse(json["order_date"]),
        billingRate: json["billing_rate"],
        quantity: json["quantity"],
        offerValidity: json["offer_validity"] == null
            ? null
            : DateTime.parse(json["offer_validity"]),
        deliveryAddress: json["delivery_address"],
        vehicle: json["vehicle"],
        remarks: json["remarks"],
        paymentTermType: json["payment_term_type"],
        noOfDays: json["no_of_days"],
        paymenttermId: json["paymentterm_id"],
        customerId: json["customer_id"],
        userId: json["user_id"],
        saleofficerId: json["saleofficer_id"],
        companyId: json["company_id"],
        dateEn:
            json["date_en"] == null ? null : DateTime.parse(json["date_en"]),
        dateNp:
            json["date_np"] == null ? null : DateTime.parse(json["date_np"]),
        status: json["status"],
        user: json["get_user"] == null ? null : User.fromJson(json["get_user"]),
        createdBy: json["created_by"],
        updatedBy: json["updated_by"],
        deletedBy: json["deleted_by"],
        deletedAt: json["deleted_at"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "booklet_number": bookletNumber,
        "approved_by": approvedBy,
        "todays_rate": todaysRate,
        "order_date": orderDate?.toIso8601String(),
        "billing_rate": billingRate,
        "quantity": quantity,
        "offer_validity":
            "${offerValidity!.year.toString().padLeft(4, '0')}-${offerValidity!.month.toString().padLeft(2, '0')}-${offerValidity!.day.toString().padLeft(2, '0')}",
        "delivery_address": deliveryAddress,
        "vehicle": vehicle,
        "remarks": remarks,
        "payment_term_type": paymentTermType,
        "no_of_days": noOfDays,
        "paymentterm_id": paymenttermId,
        "customer_id": customerId,
        "user_id": userId,
        "saleofficer_id": saleofficerId,
        "company_id": companyId,
        "date_en":
            "${dateEn!.year.toString().padLeft(4, '0')}-${dateEn!.month.toString().padLeft(2, '0')}-${dateEn!.day.toString().padLeft(2, '0')}",
        "date_np":
            "${dateNp!.year.toString().padLeft(4, '0')}-${dateNp!.month.toString().padLeft(2, '0')}-${dateNp!.day.toString().padLeft(2, '0')}",
        "status": status,
        "created_by": createdBy,
        "updated_by": updatedBy,
        "deleted_by": deletedBy,
        "deleted_at": deletedAt,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
      };
}
