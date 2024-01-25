// To parse this JSON data, do
//
//     final paymentModel = paymentModelFromJson(jsonString);

import 'dart:convert';

PaymentModel paymentModelFromJson(String str) =>
    PaymentModel.fromJson(json.decode(str));

String paymentModelToJson(PaymentModel data) => json.encode(data.toJson());

class PaymentModel {
  int? id;
  int? paymentNo;
  String? dealerName;
  String? modeOfPayment;
  String? chequeBank;
  String? chequeNo;
  DateTime? chequeDate;
  String? depositor;
  DateTime? depositDate;
  String? depositedBankName;
  String? receivedBank;
  int? companyId;
  DateTime? dateEn;
  DateTime? dateNp;
  String? amount;
  String? status;
  int? createdBy;
  DateTime? updatedBy;
  DateTime? createdAt;
  DateTime? updatedAt;

  PaymentModel({
    this.id,
    this.paymentNo,
    this.dealerName,
    this.modeOfPayment,
    this.chequeBank,
    this.chequeNo,
    this.chequeDate,
    this.depositor,
    this.depositDate,
    this.depositedBankName,
    this.receivedBank,
    this.companyId,
    this.dateEn,
    this.dateNp,
    this.amount,
    this.status,
    this.createdBy,
    this.updatedBy,
    this.createdAt,
    this.updatedAt,
  });

  factory PaymentModel.fromJson(Map<String, dynamic> json) => PaymentModel(
        id: json["id"],
        paymentNo: json["payment_no"],
        dealerName: json["dealer_name"],
        modeOfPayment: json["mode_of_payment"],
        chequeBank: json["cheque_bank"],
        chequeNo: json["cheque_no"],
        chequeDate: json["cheque_date"] == null
            ? null
            : DateTime.parse(json["cheque_date"]),
        depositor: json["depositor"],
        depositDate: json["deposit_date"] == null
            ? null
            : DateTime.parse(json["deposit_date"]),
        depositedBankName: json["deposited_bank_name"],
        receivedBank: json["received_bank"],
        companyId: json["company_id"],
        dateEn:
            json["date_en"] == null ? null : DateTime.parse(json["date_en"]),
        dateNp:
            json["date_np"] == null ? null : DateTime.parse(json["date_np"]),
        amount: json["amount"],
        status: json["status"],
        createdBy: json["created_by"],
        updatedBy: json["updated_by"] == null
            ? null
            : DateTime.parse(json["updated_by"]),
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "payment_no": paymentNo,
        "dealer_name": dealerName,
        "mode_of_payment": modeOfPayment,
        "cheque_bank": chequeBank,
        "cheque_no": chequeNo,
        "cheque_date":
            "${chequeDate!.year.toString().padLeft(4, '0')}-${chequeDate!.month.toString().padLeft(2, '0')}-${chequeDate!.day.toString().padLeft(2, '0')}",
        "depositor": depositor,
        "deposit_date":
            "${depositDate!.year.toString().padLeft(4, '0')}-${depositDate!.month.toString().padLeft(2, '0')}-${depositDate!.day.toString().padLeft(2, '0')}",
        "deposited_bank_name": depositedBankName,
        "received_bank": receivedBank,
        "company_id": companyId,
        "date_en":
            "${dateEn!.year.toString().padLeft(4, '0')}-${dateEn!.month.toString().padLeft(2, '0')}-${dateEn!.day.toString().padLeft(2, '0')}",
        "date_np":
            "${dateNp!.year.toString().padLeft(4, '0')}-${dateNp!.month.toString().padLeft(2, '0')}-${dateNp!.day.toString().padLeft(2, '0')}",
        "amount": amount,
        "status": status,
        "created_by": createdBy,
        "updated_by": updatedBy?.toIso8601String(),
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
      };
}
