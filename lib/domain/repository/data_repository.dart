import 'package:readmock/data/request/create_booklet_request.dart';
import 'package:readmock/data/request/create_customer_request.dart';
import 'package:readmock/domain/model/booklet.dart';
import 'package:readmock/domain/model/payment_term.dart';
import 'package:readmock/domain/model/user.dart';

import '../../constant/config.dart';
import '../../data/request/accept_booking_reqeuest.dart';
import '../../data/request/online_toggle_request.dart';
import '../../data/request/payment_request.dart';
import '../../data/request/start_trip_request.dart';
import '../model/blog.dart';
import '../model/payment_model.dart';
import '../model/trip.dart';

abstract class DataRepository {
  EitherData<List<User>> getCustomer();
  //Create customer
  EitherData<String> createCustomer(
      CreateCustomerRequest createCustomerRequest);

  //get booklet
  EitherData<List<Booklet>> getBooklet();

  //Create booklet
  EitherData<String> createBooklet(CreateBookletRequest createBookletRequest);

  //get blog list
  EitherData<List<Blog>> getBlog();

  //get payment terms
  EitherData<List<PaymentTerm>> getPaymentTerms();

  //create payment
  EitherData<String> createPayment(PaymentRequest paymentRequest);

  //get payments
  EitherData<List<PaymentModel>> getPayments();

  // ****** ****** ****** ****** Driver ****** ****** ****** ******

  //Toggle on and off driver

  EitherData<String> toggleDriverStatus(OnlineToggleRequest request);

  //accept reject
  EitherData<String> acceptBooking(AcceptBookingRequest request);

  EitherData<List<Trip>> getTrips();

  EitherData<String> startTrip(StartTripRequest request);

  //End Trip
  EitherData<String> endTrip(int tripId);
}
