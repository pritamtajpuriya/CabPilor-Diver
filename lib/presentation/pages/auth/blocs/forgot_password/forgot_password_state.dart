part of 'forgot_password_cubit.dart';

class ForgotPasswordState {
  final StateStatusEnum emailStatus;

  final int currentIndex;

  final StateStatusEnum otpStatus;
  final StateStatusEnum passwordStatus;

  final String emailError;
  final String otpError;
  final String passwordError;

  ForgotPasswordState({
    this.emailStatus = StateStatusEnum.initial,
    this.otpStatus = StateStatusEnum.initial,
    this.passwordStatus = StateStatusEnum.initial,
    this.currentIndex = 0,
    this.emailError = '',
    this.otpError = '',
    this.passwordError = '',
  });

  ForgotPasswordState copyWith({
    StateStatusEnum? emailStatus,
    StateStatusEnum? otpStatus,
    StateStatusEnum? passwordStatus,
    String? emailError,
    int? currentIndex,
    String? otpError,
    String? passwordError,
  }) {
    return ForgotPasswordState(
      emailStatus: emailStatus ?? this.emailStatus,
      otpStatus: otpStatus ?? this.otpStatus,
      passwordStatus: passwordStatus ?? this.passwordStatus,
      emailError: emailError ?? this.emailError,
      currentIndex: currentIndex ?? this.currentIndex,
      otpError: otpError ?? this.otpError,
      passwordError: passwordError ?? this.passwordError,
    );
  }
}
