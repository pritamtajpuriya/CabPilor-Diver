part of 'home_cubit.dart';

class HomeState {
  StateStatusEnum getLocationStatus;
  String getLocationError;
  LatLng? currentLocation;

  StateStatusEnum onlineToggleStatus;
  String onlineToggleError;
  int onlineToggleStatusValue;

  HomeState(
      {this.currentLocation =
          const LatLng(28.291093986391548, 83.99831461510747),
      this.getLocationStatus = StateStatusEnum.initial,
      this.getLocationError = '',
      this.onlineToggleStatus = StateStatusEnum.initial,
      this.onlineToggleError = '',
      this.onlineToggleStatusValue = 0});

  HomeState copyWith(
      {StateStatusEnum? getLocationStatus,
      LatLng? currentLocation,
      String? getLocationError,
      StateStatusEnum? onlineToggleStatus,
      String? onlineToggleError,
      int? onlineToggleStatusValue}) {
    return HomeState(
        getLocationStatus: getLocationStatus ?? this.getLocationStatus,
        currentLocation: currentLocation ?? this.currentLocation,
        getLocationError: getLocationError ?? this.getLocationError,
        onlineToggleStatus: onlineToggleStatus ?? this.onlineToggleStatus,
        onlineToggleError: onlineToggleError ?? this.onlineToggleError,
        onlineToggleStatusValue:
            onlineToggleStatusValue ?? this.onlineToggleStatusValue);
  }
}
