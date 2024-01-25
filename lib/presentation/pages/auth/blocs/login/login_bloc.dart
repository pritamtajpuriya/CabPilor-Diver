import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import '../../../../../data/request/login_request.dart';
import '../../../../../domain/repository/auth_repository.dart';

import '../../../../../core/utils/local_prefs.dart';
import '../../../../../data/response/login_response.dart';
import 'package:device_info_plus/device_info_plus.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final AuthRepository _authRepository;
  final LocalPrefs _localPrefs;

  LoginBloc(
    this._authRepository,
    this._localPrefs,
  ) : super(LoginInitial()) {
    on<performLoginEvent>(_onPerformLoginEvent);
  }
  //get Device id
  Future<String> _getId() async {
    var deviceInfo = DeviceInfoPlugin();
    if (Platform.isIOS) {
      var iosDeviceInfo = await deviceInfo.iosInfo;
      return iosDeviceInfo.identifierForVendor ?? "unknown"; // unique ID on iOS
    } else if (Platform.isAndroid) {
      var androidDeviceInfo = await deviceInfo.androidInfo;
      return androidDeviceInfo.id; // unique ID on Android
    } else {
      return "unknown";
    }
  }

//get model name
  Future<String> _getModelName() async {
    var deviceInfo = DeviceInfoPlugin();
    if (Platform.isIOS) {
      var iosDeviceInfo = await deviceInfo.iosInfo;
      return iosDeviceInfo.model; // unique ID on iOS
    } else if (Platform.isAndroid) {
      var androidDeviceInfo = await deviceInfo.androidInfo;
      return androidDeviceInfo.model;
    } else {
      return "unknown";
    }
  }

  Future<void> _onPerformLoginEvent(
      performLoginEvent event, Emitter<LoginState> emit) async {
    var request = LoginRequest(
      email: emailController.text,
      password: passwordController.text,
      deviceId: await _getId(),
      modelNo: await _getModelName(),
    );
    emit(LoginLoading());
    await Future.delayed(Duration(seconds: 1));

    final response = await _authRepository.login(request);
    response.fold(
      (failure) => emit(LoginFailure(failure.message)),
      (data) {
        _localPrefs.saveAccessToken(data.user!.apiToken!);
        // _localPrefs.saveRole(data.role!);

        _localPrefs.saveUser(data.user!);

        emit(LoginSuccess(data));
      },
    );
  }

  //clean up controllers

  void cleanUpControllers() {
    emailController.clear();
    passwordController.clear();
  }

  // CleanUp Controllers
  @override
  Future<void> close() async {
    emailController.dispose();
    passwordController.dispose();
    return super.close();
  }

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
}
