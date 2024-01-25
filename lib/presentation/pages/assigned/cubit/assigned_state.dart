part of 'assigned_cubit.dart';

class AssignedState {
  StateStatusEnum getAssignedStatus;
  List<Trip> assignedList;
  String getAssignedError;
  Trip? trip;
  AssignedState({
    this.getAssignedStatus = StateStatusEnum.initial,
    this.getAssignedError = '',
    this.assignedList = const [],
    this.trip,
  });
  AssignedState copyWith({
    StateStatusEnum? getAssignedStatus,
    String? getAssignedError,
    List<Trip>? assignedList,
    Trip? trip,
  }) {
    return AssignedState(
      getAssignedStatus: getAssignedStatus ?? this.getAssignedStatus,
      getAssignedError: getAssignedError ?? this.getAssignedError,
      assignedList: assignedList ?? this.assignedList,
      trip: trip ?? this.trip,
    );
  }
}
