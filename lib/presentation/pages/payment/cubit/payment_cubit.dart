import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:readmock/constant/enum.dart';
import 'package:readmock/domain/model/payment_model.dart';
import 'package:readmock/domain/repository/data_repository.dart';

import '../../../../data/request/payment_request.dart';

part 'payment_state.dart';

class PaymentCubit extends Cubit<PaymentState> {
  DataRepository _dataRepository;
  PaymentCubit(this._dataRepository) : super(PaymentState());

  //Create payment

  void createPayment(PaymentRequest paymentRequest) async {
    emit(state.copyWith(createPaymentStatus: StateStatusEnum.loading));
    var eitherData = await _dataRepository.createPayment(paymentRequest);
    eitherData.fold(
        (l) => emit(state.copyWith(
            createPaymentError: l.message,
            createPaymentStatus: StateStatusEnum.error)), (r) {
      emit(state.copyWith(
        createPaymentStatus: StateStatusEnum.success,
      ));

      emit(state.copyWith(createPaymentStatus: StateStatusEnum.initial));
    });
  }

  //get payments

  void getPayments() async {
    emit(state.copyWith(getPaymentStatus: StateStatusEnum.loading));
    var eitherData = await _dataRepository.getPayments();
    eitherData.fold(
        (l) => emit(state.copyWith(
            getPaymentError: l.message,
            getPaymentStatus: StateStatusEnum.error)), (r) {
      emit(state.copyWith(
        payments: r,
        getPaymentStatus: StateStatusEnum.success,
      ));
    });
  }
}
