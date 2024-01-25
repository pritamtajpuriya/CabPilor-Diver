part of 'order_cubit.dart';

class OrderState {
  BookingOrder? bookingOrdersModel;
  StateStatusEnum getOrdersStatus;
  String getOrdersError;
  StateStatusEnum acceptOrderStatus;
  String acceptOrderError;
  String acceptOrderMessage;
  OrderState({
    this.getOrdersStatus = StateStatusEnum.initial,
    this.getOrdersError = '',
    this.bookingOrdersModel,
    this.acceptOrderStatus = StateStatusEnum.initial,
    this.acceptOrderError = '',
    this.acceptOrderMessage = '',
  });
  OrderState copyWith({
    StateStatusEnum? getOrdersStatus,
    String? getOrdersError,
    BookingOrder? bookingOrdersModel,
    StateStatusEnum? acceptOrderStatus,
    String? acceptOrderError,
    String? acceptOrderMessage,
  }) {
    return OrderState(
      getOrdersStatus: getOrdersStatus ?? this.getOrdersStatus,
      getOrdersError: getOrdersError ?? this.getOrdersError,
      bookingOrdersModel: bookingOrdersModel ?? this.bookingOrdersModel,
      acceptOrderStatus: acceptOrderStatus ?? this.acceptOrderStatus,
      acceptOrderError: acceptOrderError ?? this.acceptOrderError,
      acceptOrderMessage: acceptOrderMessage ?? this.acceptOrderMessage,
    );
  }
}
