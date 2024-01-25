class AcceptBookingRequest {
  int userId;
  String token;
  int status;
  int tripId;

  AcceptBookingRequest(
      {required this.userId,
      required this.token,
      required this.status,
      required this.tripId});

  Map<String, dynamic> toJson() {
    return {
      'user_id': userId,
      'token': token,
      'status': status,
      'trip_id': tripId
    };
  }
}
