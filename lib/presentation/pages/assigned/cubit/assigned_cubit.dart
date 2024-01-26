import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:readmock/constant/enum.dart';
import 'package:readmock/data/request/start_trip_request.dart';
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
          assignedList: r.reversed.toList(),
          getAssignedStatus: StateStatusEnum.success));
    });
  }

  startTrip(StartTripRequest request) async {
    emit(state.copyWith(startTripStatus: StateStatusEnum.loading));
    var response = await _dataRepository.startTrip(request);
    response.fold((l) {
      emit(state.copyWith(
          startTripStatus: StateStatusEnum.error, startTripError: l.message));
      emit(state.copyWith(startTripStatus: StateStatusEnum.initial));
    }, (r) {
      var trip = state.trip!.copyWith(
        tripStatus: 0,
      );
      emit(
          state.copyWith(startTripStatus: StateStatusEnum.initial, trip: trip));

      getTripsList();
    });
  }

  setTrip(Trip trip) {
    emit(state.copyWith(trip: trip, startTripStatus: StateStatusEnum.initial));
  }

  endTrip(int tripId) async {
    emit(state.copyWith(startTripStatus: StateStatusEnum.loading));
    var response = await _dataRepository.endTrip(tripId);
    response.fold((l) {
      emit(state.copyWith(
          startTripStatus: StateStatusEnum.error, startTripError: l.message));
    }, (r) {
      var trip = state.trip!.copyWith(
        tripStatus: 1,
      );

      emit(
          state.copyWith(startTripStatus: StateStatusEnum.success, trip: trip));
      emit(state.copyWith(startTripStatus: StateStatusEnum.initial));

      getTripsList();
    });
  }
}
