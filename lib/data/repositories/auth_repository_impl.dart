import 'package:dartz/dartz.dart';
import 'package:readmock/domain/model/user.dart';
import '../../core/errors/failure.dart';
import '../request/forgot_password_request.dart';
import '../request/register.request.dart';

import '../../constant/config.dart';

import '../../core/errors/exceptions.dart';
import '../../core/networks/network_info.dart';
import '../../domain/repository/auth_repository.dart';

import '../request/login_request.dart';
import '../response/login_response.dart';

import 'package:dio/dio.dart';

class AuthRepositoryImpl implements AuthRepository {
  final Dio _dio;
  final NetworkInfo _networkInfo;

  AuthRepositoryImpl(this._dio, this._networkInfo);

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
  EitherData<LoginResponse> login(LoginRequest loginRequest) async {
    return _execute(() async {
      try {
        final response = await _dio.post(
          'driver/login',
          data: loginRequest.toJson(),
        );
        return LoginResponse.fromJson(response.data['data']);
      } on Exception catch (e) {
        throw ServerException(message: e.toString());
      }
    });
  }

  @override
  EitherData<LoginResponse> register(RegisterRequest registerRequest) async {
    return _execute(() async {
      try {
        final response = await _dio.post(
          'account/register/',
          data: registerRequest.toJson(),
        );
        return LoginResponse.fromJson(response.data['data']);
      } on Exception catch (e) {
        throw ServerException(message: e.toString());
      }
    });
  }

  @override
  EitherData<String> forgotPassword(ForgotPasswordRequest request) async {
    return _execute(() async {
      try {
        final response = await _dio.post(
          'account/forgot-password/',
          data: request.toJson(),
        );
        return response.data['data']['detail'];
      } on Exception catch (e) {
        throw ServerException(message: e.toString());
      }
    });
  }

  @override
  EitherData<String> verifyOtp(ForgotPasswordRequest request) async {
    return _execute(() async {
      try {
        final response = await _dio.post(
          'account/verify-otp/',
          data: request.toJson(),
        );
        return 'success';
      } on Exception catch (e) {
        throw ServerException(message: e.toString());
      }
    });
  }

  @override
  EitherData<String> resetPassword(ForgotPasswordRequest request) async {
    return _execute(() async {
      try {
        final response = await _dio.post(
          'account/reset-password',
          data: request.toJson(),
        );
        return 'success';
      } on Exception catch (e) {
        throw ServerException(message: e.toString());
      }
    });
  }

  @override
  EitherData<User> getProfile() async {
    return _execute(() async {
      try {
        final response = await _dio.get('user-profile');
        return User.fromJson(response.data['user']);
      } on Exception catch (e) {
        throw ServerException(message: e.toString());
      }
    });
  }
}
