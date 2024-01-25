import 'dart:convert';
import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:readmock/core/di/locator.dart';
import 'package:readmock/core/utils/local_prefs.dart';
import 'package:readmock/data/request/accept_booking_reqeuest.dart';
import 'package:readmock/data/request/create_booklet_request.dart';
import 'package:readmock/data/request/create_customer_request.dart';
import 'package:readmock/data/request/online_toggle_request.dart';
import 'package:readmock/data/request/payment_request.dart';
import 'package:readmock/domain/model/blog.dart';
import 'package:readmock/domain/model/booklet.dart';
import 'package:readmock/domain/model/payment_model.dart';
import 'package:readmock/domain/model/payment_term.dart';
import 'package:readmock/domain/model/trip.dart';
import 'package:readmock/domain/model/user.dart';

import 'package:readmock/constant/config.dart';

import '../../core/errors/exceptions.dart';
import '../../core/errors/failure.dart';
import '../../core/networks/network_info.dart';
import '../../domain/repository/data_repository.dart';

class DataRepositoryImpl implements DataRepository {
  final Dio _dio;
  final NetworkInfo _networkInfo;

  DataRepositoryImpl(this._dio, this._networkInfo);

  Future<Either<Failure, T>> _execute<T>(
    Future<T> Function() requestFunction,
  ) async {
    if (!(await _networkInfo.isConnected())) {
      return Left(NoInternetFailure());
    }

    try {
      final response = await requestFunction();
      return Right(response);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    }
  }

  @override
  EitherData<List<User>> getCustomer() async {
    return _execute(() async {
      var role = await getInstance<LocalPrefs>().getRole();
      try {
        final response = await _dio.get(
          '$role/customer-list',
        );
        return response.data['customers']
            .map<User>((e) => User.fromJson(e))
            .toList();
      } on Exception catch (e) {
        throw ServerException(message: e.toString());
      }
    });
  }

  @override
  EitherData<String> createCustomer(CreateCustomerRequest request) async {
    log(jsonEncode(request.toJson()));
    var role = await getInstance<LocalPrefs>().getRole();
    return _execute(() async {
      try {
        final response = await _dio.post(
          '$role/customer/store',
          data: request.toJson(),
        );

        return response.data['message'];
      } on Exception catch (e) {
        throw ServerException(message: e.toString());
      }
    });
  }

  @override
  EitherData<List<Booklet>> getBooklet() async {
    var role = await getInstance<LocalPrefs>().getRole();
    return _execute(() async {
      try {
        final response = await _dio.get(
          '$role/booklet',
        );
        return response.data['booklets']
            .map<Booklet>((e) => Booklet.fromJson(e))
            .toList();
      } on Exception catch (e) {
        throw ServerException(message: e.toString());
      }
    });
  }

  @override
  EitherData<List<Blog>> getBlog() {
    return _execute(() async {
      try {
        final response = await _dio.get(
          'blogs',
        );
        return response.data['blogs']
            .map<Blog>((e) => Blog.fromJson(e))
            .toList();
      } on Exception catch (e) {
        throw ServerException(message: e.toString());
      }
    });
  }

  @override
  EitherData<String> createBooklet(
      CreateBookletRequest createBookletRequest) async {
    var role = await getInstance<LocalPrefs>().getRole();

    log(jsonEncode(createBookletRequest.toJson()));
    return _execute(() async {
      try {
        final response = await _dio.post(
          '$role/booklet/store',
          data: createBookletRequest.toJson(),
        );
        return response.data['message'];
      } on Exception catch (e) {
        throw ServerException(message: e.toString());
      }
    });
  }

  @override
  EitherData<List<PaymentTerm>> getPaymentTerms() async {
    return _execute(() async {
      try {
        final response = await _dio.get(
          'payment_term',
        );
        return response.data['data']
            .map<PaymentTerm>((e) => PaymentTerm.fromJson(e))
            .toList();
      } on Exception catch (e) {
        throw ServerException(message: e.toString());
      }
    });
  }

  @override
  EitherData<String> createPayment(PaymentRequest paymentRequest) async {
    var role = await getInstance<LocalPrefs>().getRole();

    log(jsonEncode(paymentRequest.toJson()));
    return _execute(() async {
      try {
        final response = await _dio.post(
          '$role/payment/store',
          data: paymentRequest.toJson(),
        );
        return response.data['message'];
      } on Exception catch (e) {
        throw ServerException(message: e.toString());
      }
    });
  }

  @override
  EitherData<List<PaymentModel>> getPayments() async {
    return _execute(() async {
      try {
        final response = await _dio.get(
          'payment-list',
        );
        return response.data['data']
            .map<PaymentModel>((e) => PaymentModel.fromJson(e))
            .toList();
      } on Exception catch (e) {
        throw ServerException(message: e.toString());
      }
    });
  }

  @override
  EitherData<String> toggleDriverStatus(OnlineToggleRequest request) async {
    return _execute(() async {
      try {
        final response = await _dio.post(
          'driver/toggle',
          data: request.toJson(),
        );
        return response.data['message'];
      } on Exception catch (e) {
        throw ServerException(message: e.toString());
      }
    });
  }

  @override
  EitherData<String> acceptBooking(AcceptBookingRequest request) async {
    log(jsonEncode(request.toJson()));
    return _execute(() async {
      try {
        final response = await _dio.post(
          'trip/confirm',
          data: request.toJson(),
        );
        //if status true
        if (response.data['status'] == true) {
          return response.data['message'];
        } else {
          throw ServerException(message: response.data['message']);
        }
      } on Exception catch (e) {
        throw ServerException(message: e.toString());
      }
    });
  }

  @override
  EitherData<List<Trip>> getTrips() async {
    var token = await getInstance<LocalPrefs>().getAccessToken();
    var user = await getInstance<LocalPrefs>().getUser();
    return _execute(() async {
      try {
        final response = await _dio.post('my/assigned/trip', data: {
          'token': token,
          'user_id': user!.id!,
        });
        if (response.data['data'] != null) {
          return response.data['data']
              .map<Trip>((e) => Trip.fromJson(e))
              .toList();
        } else {
          return [];
        }
      } on Exception catch (e) {
        throw ServerException(message: e.toString());
      }
    });
  }
}
