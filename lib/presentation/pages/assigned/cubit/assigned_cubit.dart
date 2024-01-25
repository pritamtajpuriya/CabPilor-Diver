import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:readmock/constant/enum.dart';
import 'package:readmock/domain/model/trip.dart';
import 'package:readmock/domain/repository/data_repository.dart';

part 'assigned_state.dart';

class AssignedCubit extends Cubit<AssignedState> {
  DataRepository _dataRepository;
  AssignedCubit(
    this._dataRepository,
  ) : super(AssignedState());

  getTripsList() async {
    emit(state.copyWith(getAssignedStatus: StateStatusEnum.loading));
    var response = await _dataRepository.getTrips();
    response.fold((l) {
      emit(state.copyWith(
          getAssignedError: l.message,
          getAssignedStatus: StateStatusEnum.error));
    }, (r) {
      emit(state.copyWith(
          assignedList: r, getAssignedStatus: StateStatusEnum.success));
    });
  }
}
