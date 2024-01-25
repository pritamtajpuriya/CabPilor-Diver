part of 'customer_cubit.dart';

class CustomerState {
  StateStatusEnum createCustomerStatus;

  String createCustomerError;

  StateStatusEnum getCustomerStatus;

  String getCustomerError;

  List<User> customers;

  CustomerState({
    this.createCustomerStatus = StateStatusEnum.initial,
    this.createCustomerError = '',
    this.getCustomerStatus = StateStatusEnum.initial,
    this.getCustomerError = '',
    this.customers = const [],
  });

  CustomerState copyWith({
    StateStatusEnum? createCustomerStatus,
    String? createCustomerError,
    StateStatusEnum? getCustomerStatus,
    String? getCustomerError,
    List<User>? customers,
  }) {
    return CustomerState(
      createCustomerStatus: createCustomerStatus ?? this.createCustomerStatus,
      createCustomerError: createCustomerError ?? this.createCustomerError,
      getCustomerStatus: getCustomerStatus ?? this.getCustomerStatus,
      getCustomerError: getCustomerError ?? this.getCustomerError,
      customers: customers ?? this.customers,
    );
  }
}
