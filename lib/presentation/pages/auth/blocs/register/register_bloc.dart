import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import '../../../../../core/utils/local_prefs.dart';
import '../../../../../data/request/register.request.dart';
import '../../../../../data/response/login_response.dart';
import '../../../../../domain/repository/auth_repository.dart';

part 'register_event.dart';
part 'register_state.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  final AuthRepository _authRepository;
  final LocalPrefs _localPrefs;

  RegisterBloc(
    this._authRepository,
    this._localPrefs,
  ) : super(RegisterInitial()) {
    on<PerformRegister>(_onPerformLoginEvent);
  }

  Future<void> _onPerformLoginEvent(
      PerformRegister event, Emitter<RegisterState> emit) async {
    var request = RegisterRequest(
      email: emailController.text,
      password: passwordController.text,
      fullName: fullNameController.text,
    );

    emit(RegisterLoading());
    final response = await _authRepository.register(request);
    response.fold(
      (l) => emit(RegisterFailure(message: l.message)),
      (data) {
        // _localPrefs.saveAccessToken(data.to);

        emit(RegisterSuccess(loginResponse: data));
      },
    );
  }

  // CleanUp Controllers
  @override
  Future<void> close() {
    emailController.dispose();
    passwordController.dispose();
    fullNameController.dispose();
    confirmPasswordController.dispose();
    return super.close();
  }

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController fullNameController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
}
