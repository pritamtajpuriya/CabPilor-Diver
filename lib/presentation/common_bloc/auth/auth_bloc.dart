import 'dart:async';
import 'dart:developer';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/utils/local_prefs.dart';
import '../../../domain/repository/auth_repository.dart';

import '../../../constant/enum.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final LocalPrefs _localPrefs;
  final AuthRepository _authRepository;
  AuthBloc(
    this._authRepository,
    this._localPrefs,
  ) : super(const AuthState.unknown()) {
    on<AuthCheck>(_onAuthCheck);
  }

  _onAuthCheck(AuthEvent event, Emitter<AuthState> emit) async {
    print('AuthBloc: _onAuthCheck');

    final accessToken = await _localPrefs.getAccessToken();

    print('AuthBloc: accessToken: $accessToken');

    // Delay 1s to show splash screen

    // emit(const AuthState.unauthenticated());

    var token = await _localPrefs.getAccessToken();
    if (token == '') {
      emit(const AuthState.unauthenticated());
    } else {
      emit(const AuthState.authenticated());
      // var result = await _authRepository.getProfile();

      // result.fold((failer) {
      //   log('AuthBloc: _onAuthCheck: $failer');
      //   if (failer.message == 'user_not_found')
      //   // clear cache
      //   {
      //     _localPrefs.clearAll();
      //     emit(const AuthState.unauthenticated());
      //   } else {
      //     emit(const AuthState.unauthenticated());
      //   }
      // }, (data) {
      //   emit(const AuthState.authenticated());

      //   _localPrefs.saveUser(data);
      // });
    }
  }
}
