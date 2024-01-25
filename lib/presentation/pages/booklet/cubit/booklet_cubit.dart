import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:readmock/constant/enum.dart';
import 'package:readmock/domain/model/payment_term.dart';
import 'package:readmock/domain/repository/data_repository.dart';

import '../../../../constant/config.dart';
import '../../../../data/request/create_booklet_request.dart';
import '../../../../domain/model/booklet.dart';

part 'booklet_state.dart';

class BookletCubit extends Cubit<BookletState> {
  DataRepository _dataRepository;
  BookletCubit(this._dataRepository) : super(BookletState());

  getBooklets() async {
    emit(state.copyWith(getBookletStatus: StateStatusEnum.loading));
    var response = await _dataRepository.getBooklet();
    response.fold(
      (l) => emit(state.copyWith(
          getBookletError: l.message, getBookletStatus: StateStatusEnum.error)),
      (r) => emit(state.copyWith(
          booklets: r, getBookletStatus: StateStatusEnum.success)),
    );
  }

  //create booklet
  createBooklet(CreateBookletRequest createBookletRequest) async {
    emit(state.copyWith(createBookletStatus: StateStatusEnum.loading));
    var res = await _dataRepository.createBooklet(createBookletRequest);

    res.fold((l) {
      emit(state.copyWith(
          createBookletError: l.message,
          createBookletStatus: StateStatusEnum.error));
    }, (r) {
      emit(state.copyWith(createBookletStatus: StateStatusEnum.success));
      emit(state.copyWith(createBookletStatus: StateStatusEnum.initial));
    });
  }

  //get payment terms
  getPaymentTerms() async {
    emit(state.copyWith(paymentTermStatus: StateStatusEnum.loading));
    var response = await _dataRepository.getPaymentTerms();
    response.fold(
      (l) => emit(state.copyWith(
          paymentTermError: l.message,
          paymentTermStatus: StateStatusEnum.error)),
      (r) => emit(state.copyWith(
          paymentTerms: r, paymentTermStatus: StateStatusEnum.success)),
    );
  }
}
