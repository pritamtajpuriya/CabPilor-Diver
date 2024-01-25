import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import '../../../../../data/request/forgot_password_request.dart';
import '../../../../../domain/repository/auth_repository.dart';

import '../../../../../constant/enum.dart';

part 'forgot_password_state.dart';

class ForgotPasswordCubit extends Cubit<ForgotPasswordState> {
  final AuthRepository _authRepository;

  ForgotPasswordCubit(
    this._authRepository,
  ) : super(ForgotPasswordState());

  final PageController pageController = PageController(initialPage: 0);

  var currentIndex = 0;

  void checkIfEmailIsValid() async {
    var request = ForgotPasswordRequest(email: emailController.text, otp: '');

    emit(state.copyWith(emailStatus: StateStatusEnum.loading));

    final response = await _authRepository.forgotPassword(request);

    response.fold((l) {
      emit(state.copyWith(emailError: l.message));
      emit(state.copyWith(emailStatus: StateStatusEnum.error));
      emit(state.copyWith(emailStatus: StateStatusEnum.initial));
    },
        (r) => {
              //removed focus
              // emailFocusNode.unfocus(),
              //This no work
              //Unfocus all
              emailFocusNode.unfocus(),

              emit(state.copyWith(currentIndex: 1)),
              emit(state.copyWith(emailStatus: StateStatusEnum.success)),
              pageController.nextPage(
                duration: Duration(milliseconds: 300),
                curve: Curves.easeIn,
              ),
              emit(state.copyWith(emailStatus: StateStatusEnum.initial)),
            });
  }

  void checkIfOtpIsValid() async {
    emit(state.copyWith(otpStatus: StateStatusEnum.loading));

    var request = ForgotPasswordRequest(
        email: emailController.text, otp: otpController.text);

    final response = await _authRepository.verifyOtp(request);
    response.fold((l) {
      emit(state.copyWith(otpError: l.message));
      emit(state.copyWith(otpStatus: StateStatusEnum.error));
      emit(state.copyWith(otpStatus: StateStatusEnum.initial));
    },
        (r) => {
              emit(state.copyWith(currentIndex: 2)),
              emit(state.copyWith(otpStatus: StateStatusEnum.success)),
              pageController.nextPage(
                duration: Duration(milliseconds: 300),
                curve: Curves.easeIn,
              ),
              emit(state.copyWith(otpStatus: StateStatusEnum.initial)),
            });
  }

  void resetPassword() async {
    emit(state.copyWith(passwordStatus: StateStatusEnum.loading));

    var request = ForgotPasswordRequest(
        email: emailController.text,
        otp: otpController.text,
        password: passwordController.text,
        confirmPassword: confirmPasswordController.text);

    final response = await _authRepository.resetPassword(request);
    response.fold((l) {
      emit(state.copyWith(passwordError: l.message));
      emit(state.copyWith(passwordStatus: StateStatusEnum.error));
      emit(state.copyWith(passwordStatus: StateStatusEnum.initial));
    },
        (r) => {
              emit(state.copyWith(passwordStatus: StateStatusEnum.success)),
              pageController.nextPage(
                duration: Duration(milliseconds: 300),
                curve: Curves.easeIn,
              ),
              emit(state.copyWith(passwordStatus: StateStatusEnum.initial)),
            });
  }

  // Destroy Bloc
  @override
  Future<void> close() async {
    log('Destroying forgot password cubit');
    pageController.dispose();
    return super.close();
  }

  final TextEditingController emailController = TextEditingController();
  FocusNode emailFocusNode = FocusNode();
  final TextEditingController otpController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
}
