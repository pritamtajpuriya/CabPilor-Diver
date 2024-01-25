import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:readmock/domain/model/order.dart';
import 'package:readmock/domain/repository/data_repository.dart';

import '../../../../constant/enum.dart';
import '../../../../core/di/locator.dart';
import '../../../../core/utils/local_prefs.dart';
import '../../../../data/request/accept_booking_reqeuest.dart';

part 'order_state.dart';

class OrderCubit extends Cubit<OrderState> {
  DataRepository _dataRepository;
  OrderCubit(
    this._dataRepository,
  ) : super(OrderState());

  //set Order
  void setOrders(BookingOrder orders) {
    emit(state.copyWith(bookingOrdersModel: orders));
  }

  //accept reject
  void acceptRejectOrder(int status) async {
    var token = await getInstance<LocalPrefs>().getAccessToken();
    var user = await getInstance<LocalPrefs>().getUser();

    var reqest = AcceptBookingRequest(
      userId: user!.id!,
      token: token!,
      status: status,
      tripId: state.bookingOrdersModel!.id!,
    );
    emit(state.copyWith(acceptOrderStatus: StateStatusEnum.loading));

    var response = await _dataRepository.acceptBooking(reqest);
    response.fold((l) {
      emit(state.copyWith(
          acceptOrderStatus: StateStatusEnum.error,
          acceptOrderError: l.message));

      emit(state.copyWith(acceptOrderStatus: StateStatusEnum.initial));
    }, (r) {
      emit(state.copyWith(
        acceptOrderStatus: StateStatusEnum.success,
        acceptOrderMessage: r,
      ));
      emit(state.copyWith(acceptOrderStatus: StateStatusEnum.initial));
    });
  }
}
