// To parse this JSON data, do
//
//     final paymentTerm = paymentTermFromJson(jsonString);

import 'dart:convert';

PaymentTerm paymentTermFromJson(String str) =>
    PaymentTerm.fromJson(json.decode(str));

String paymentTermToJson(PaymentTerm data) => json.encode(data.toJson());

class PaymentTerm {
  int? id;
  int? noOfDays;
  String? label;
  String? defaultValue;
  int? companyId;
  DateTime? dateEn;
  DateTime? dateNp;
  String? status;

  PaymentTerm({
    this.id,
    this.noOfDays,
    this.label,
    this.defaultValue,
    this.companyId,
    this.dateEn,
    this.dateNp,
    this.status,
  });

  factory PaymentTerm.fromJson(Map<String, dynamic> json) => PaymentTerm(
        id: json["id"],
        noOfDays: json["no_of_days"],
        label: json["label"],
        defaultValue: json["default_value"],
        companyId: json["company_id"],
        dateEn:
            json["date_en"] == null ? null : DateTime.parse(json["date_en"]),
        dateNp:
            json["date_np"] == null ? null : DateTime.parse(json["date_np"]),
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "no_of_days": noOfDays,
        "label": label,
        "default_value": defaultValue,
        "company_id": companyId,
        "date_en":
            "${dateEn!.year.toString().padLeft(4, '0')}-${dateEn!.month.toString().padLeft(2, '0')}-${dateEn!.day.toString().padLeft(2, '0')}",
        "date_np":
            "${dateNp!.year.toString().padLeft(4, '0')}-${dateNp!.month.toString().padLeft(2, '0')}-${dateNp!.day.toString().padLeft(2, '0')}",
        "status": status,
      };
}
