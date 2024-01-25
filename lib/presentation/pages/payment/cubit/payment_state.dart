part of 'payment_cubit.dart';

class PaymentState {
  StateStatusEnum getPaymentStatus;

  String getPaymentError;

  List<PaymentModel> payments;
  StateStatusEnum createPaymentStatus;

  String createPaymentError;

  PaymentState({
    this.getPaymentStatus = StateStatusEnum.initial,
    this.getPaymentError = '',
    this.payments = const [],
    this.createPaymentStatus = StateStatusEnum.initial,
    this.createPaymentError = '',
  });

  PaymentState copyWith({
    StateStatusEnum? getPaymentStatus,
    String? getPaymentError,
    List<PaymentModel>? payments,
    StateStatusEnum? createPaymentStatus,
    String? createPaymentError,
  }) {
    return PaymentState(
      getPaymentStatus: getPaymentStatus ?? this.getPaymentStatus,
      getPaymentError: getPaymentError ?? this.getPaymentError,
      payments: payments ?? this.payments,
      createPaymentStatus: createPaymentStatus ?? this.createPaymentStatus,
      createPaymentError: createPaymentError ?? this.createPaymentError,
    );
  }
}
