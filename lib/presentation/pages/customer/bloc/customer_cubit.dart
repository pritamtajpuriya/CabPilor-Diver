import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:readmock/constant/enum.dart';
import 'package:readmock/data/request/create_customer_request.dart';
import 'package:readmock/domain/repository/data_repository.dart';

import '../../../../domain/model/user.dart';

part 'customer_state.dart';

class CustomerCubit extends Cubit<CustomerState> {
  DataRepository _dataRepository;
  CustomerCubit(
    this._dataRepository,
  ) : super(CustomerState());

  void getCustomers() async {
    emit(state.copyWith(getCustomerStatus: StateStatusEnum.loading));

    var response = await _dataRepository.getCustomer();
    response.fold(
      (l) => emit(state.copyWith(
          getCustomerError: l.message,
          getCustomerStatus: StateStatusEnum.error)),
      (r) => emit(state.copyWith(
          customers: r, getCustomerStatus: StateStatusEnum.success)),
    );
  }

  void createCustomer(CreateCustomerRequest customer) async {
    emit(state.copyWith(createCustomerStatus: StateStatusEnum.loading));
    var response = await _dataRepository.createCustomer(customer);
    response.fold(
      (l) => emit(state.copyWith(
          createCustomerError: l.message,
          createCustomerStatus: StateStatusEnum.error)),
      (r) =>
          emit(state.copyWith(createCustomerStatus: StateStatusEnum.success)),
    );
  }
}
