part of 'assigned_cubit.dart';

class AssignedState {
  StateStatusEnum getAssignedStatus;
  List<Trip> assignedList;
  String getAssignedError;
  Trip? trip;

  StateStatusEnum startTripStatus = StateStatusEnum.initial;
  String startTripError = '';

  AssignedState({
    this.getAssignedStatus = StateStatusEnum.initial,
    this.getAssignedError = '',
    this.assignedList = const [],
    this.trip,
    this.startTripStatus = StateStatusEnum.initial,
    this.startTripError = '',
  });
  AssignedState copyWith({
    StateStatusEnum? getAssignedStatus,
    String? getAssignedError,
    List<Trip>? assignedList,
    Trip? trip,
    StateStatusEnum? startTripStatus,
    String? startTripError,
  }) {
    return AssignedState(
      getAssignedStatus: getAssignedStatus ?? this.getAssignedStatus,
      getAssignedError: getAssignedError ?? this.getAssignedError,
      assignedList: assignedList ?? this.assignedList,
      trip: trip ?? this.trip,
      startTripStatus: startTripStatus ?? this.startTripStatus,
      startTripError: startTripError ?? this.startTripError,
    );
  }
}
