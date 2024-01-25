class OnlineToggleRequest {
  int status;
  String lat;
  String lng;
  int userId;
  String token;
  String fcmToken;

  OnlineToggleRequest(
      {required this.status,
      required this.lat,
      required this.lng,
      required this.userId,
      required this.fcmToken,
      required this.token});

  Map<String, dynamic> toJson() {
    return {
      'status': status,
      'lat': lat,
      'lng': lng,
      'user_id': userId,
      'token': token,
      'fcm_token': fcmToken
    };
  }
}
