import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:readmock/constant/enum.dart';
import 'package:readmock/core/di/locator.dart';
import 'package:readmock/data/request/online_toggle_request.dart';
import 'package:readmock/domain/repository/data_repository.dart';

import '../../../../core/utils/local_prefs.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  DataRepository _dataRepository;
  HomeCubit(
    this._dataRepository,
  ) : super(HomeState());

//get Current Location

//GoogleMapConroler
  late GoogleMapController mapController;

  late Timer timer;

  @override
  Future<void> close() {
    mapController.dispose();
    return super.close();
  }

  Future<void> getLocation() async {
    emit(state.copyWith(getLocationStatus: StateStatusEnum.loading));

    LocationPermission permission = await Geolocator.requestPermission();

    permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied) {
      emit(state.copyWith(
          getLocationError: "Permission Denied",
          getLocationStatus: StateStatusEnum.error));
    } else if (permission == LocationPermission.deniedForever) {
      emit(state.copyWith(
          getLocationError: "Permission Permanently Denied",
          getLocationStatus: StateStatusEnum.error));
    } else {
      var response = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.bestForNavigation);
      if (response != null) {
        log("Current Location: ${response.latitude} ${response.longitude}");
        emit(state.copyWith(
          currentLocation: LatLng(response.latitude, response.longitude),
          getLocationStatus: StateStatusEnum.success,
        ));
      }
    }
  }

  // Timer periodic call for online toggle

  void startTimer() async {
    const oneSec = Duration(seconds: 60);

    if (state.onlineToggleStatusValue == 0) {
      onlineToggle(1);
      timer = Timer.periodic(oneSec, (Timer t) async {
        await onlineToggle(1);
      });
    } else {
      timer.cancel();
      await onlineToggle(0);
    }
  }

  //OnlineToggle
  onlineToggle(int value) async {
    emit(state.copyWith(onlineToggleStatus: StateStatusEnum.loading));

    var token = await getInstance<LocalPrefs>().getAccessToken();
    var user = await getInstance<LocalPrefs>().getUser();
    FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;

    var fcmToken = await _firebaseMessaging.getToken();
    log(fcmToken.toString());

    var reqest = OnlineToggleRequest(
      status: value,
      lat: state.currentLocation!.latitude.toString(),
      lng: state.currentLocation!.longitude.toString(),
      userId: user!.id!,
      token: token!,
      fcmToken: fcmToken!,
    );

    var response = await _dataRepository.toggleDriverStatus(
      reqest,
    );
    response.fold(
      (l) => emit(state.copyWith(
          onlineToggleError: l.message,
          onlineToggleStatus: StateStatusEnum.error)),
      (r) => emit(state.copyWith(
          onlineToggleStatusValue: value,
          onlineToggleStatus: StateStatusEnum.success)),
    );
  }
}
