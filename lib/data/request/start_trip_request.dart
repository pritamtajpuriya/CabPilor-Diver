import 'dart:io';

class StartTripRequest {
  int tripId;
  File? frontImage;
  File? backImage;
  File? leftImage;
  File? rightImage;

  StartTripRequest(
      {required this.tripId,
      this.frontImage,
      this.backImage,
      this.leftImage,
      this.rightImage});
}
