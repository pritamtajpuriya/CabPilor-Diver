// To parse this JSON data, do
//
//     final paymentRequest = paymentRequestFromJson(jsonString);

import 'dart:convert';

PaymentRequest paymentRequestFromJson(String str) =>
    PaymentRequest.fromJson(json.decode(str));

String paymentRequestToJson(PaymentRequest data) => json.encode(data.toJson());

class PaymentRequest {
  String? modeOfPayment;
  String? dealerName;
  String? chequeBank;
  String? chequeNo;
  String? amount;
  String? chequeDate;
  String? depositor;
  String? depositDate;
  String? depositBankName;
  String? recivedBank;
  String? remark;
  String? saleofficerId;

  PaymentRequest({
    this.modeOfPayment,
    this.dealerName,
    this.chequeBank,
    this.chequeNo,
    this.amount,
    this.chequeDate,
    this.depositor,
    this.depositDate,
    this.depositBankName,
    this.recivedBank,
    this.remark,
    this.saleofficerId,
  });

  factory PaymentRequest.fromJson(Map<String, dynamic> json) => PaymentRequest(
        modeOfPayment: json["mode_of_payment"],
        dealerName: json["dealer_name"],
        chequeBank: json["cheque_bank"],
        chequeNo: json["cheque_no"],
        amount: json["amount"],
        chequeDate: json["cheque_date"],
        depositor: json["depositor"],
        depositDate: json["deposit_date"],
        depositBankName: json["deposit_bank_name"],
        recivedBank: json["recived_bank"],
        remark: json["remark"],
        saleofficerId: json["saleofficer_id"],
      );

  Map<String, dynamic> toJson() => {
        "mode_of_payment": modeOfPayment,
        "dealer_name": dealerName,
        "cheque_bank": chequeBank,
        "cheque_no": chequeNo,
        "amount": amount,
        "cheque_date": chequeDate,
        "depositor": depositor,
        "deposit_date": depositDate,
        "deposit_bank_name": depositBankName,
        "recived_bank": recivedBank,
        "remark": remark,
        // "saleofficer_id": saleofficerId,
      };
}
