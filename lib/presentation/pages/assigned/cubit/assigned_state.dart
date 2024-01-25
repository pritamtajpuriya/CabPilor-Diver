part of 'assigned_cubit.dart';

class AssignedState {
  StateStatusEnum getAssignedStatus;
  List<Trip> assignedList;
  String getAssignedError;
  AssignedState({
    this.getAssignedStatus = StateStatusEnum.initial,
    this.getAssignedError = '',
    this.assignedList = const [],
  });
  AssignedState copyWith({
    StateStatusEnum? getAssignedStatus,
    String? getAssignedError,
    List<Trip>? assignedList,
  }) {
    return AssignedState(
      getAssignedStatus: getAssignedStatus ?? this.getAssignedStatus,
      getAssignedError: getAssignedError ?? this.getAssignedError,
      assignedList: assignedList ?? this.assignedList,
    );
  }
}
