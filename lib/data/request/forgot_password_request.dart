class ForgotPasswordRequest {
  String email;

  String otp;
  String? password;
  String? confirmPassword;

  ForgotPasswordRequest(
      {required this.email,
      required this.otp,
      this.password,
      this.confirmPassword});

  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'otp': otp,
      'password': password,
      'confirm_password': confirmPassword,
    };
  }
}
