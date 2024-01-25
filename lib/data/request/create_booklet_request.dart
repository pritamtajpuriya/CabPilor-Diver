class CreateBookletRequest {
  int billingRate;
  int quantity;
  String deliveryAddress;
  String vehicle;
  String remarks;
  String userId;
  String paymentTermType;

  CreateBookletRequest({
    required this.billingRate,
    required this.quantity,
    required this.deliveryAddress,
    required this.vehicle,
    required this.remarks,
    required this.userId,
    required this.paymentTermType,
  });

  Map<String, dynamic> toJson() {
    return {
      'billing_rate': billingRate,
      'quantity': quantity,
      'delivery_address': deliveryAddress,
      'vehicle': vehicle,
      'remarks': remarks,
      'user_id': userId,
      'payment_term_type': paymentTermType
    };
  }
}
