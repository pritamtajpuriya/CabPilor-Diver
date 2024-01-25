class LoginRequest {
  String email;
  String password;
  String deviceId;
  String modelNo;

  LoginRequest(
      {required this.email,
      required this.password,
      required this.deviceId,
      required this.modelNo});

  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'password': password,
      // 'device_id': deviceId,
      // 'model_no': modelNo
    };
  }
}
