import 'package:readmock/data/request/login_request.dart';
import 'package:readmock/data/request/register.request.dart';
import 'package:readmock/data/response/login_response.dart';
import 'package:readmock/domain/model/user.dart';
import 'package:readmock/presentation/pages/auth/pages/forgeot_password.dart';

import '../../constant/config.dart';
import '../../data/request/forgot_password_request.dart';

abstract class AuthRepository {
  EitherData<User> getProfile();
  EitherData<LoginResponse> login(LoginRequest loginRequest);

  EitherData<LoginResponse> register(RegisterRequest registerRequest);

  EitherData<String> forgotPassword(ForgotPasswordRequest request);
  EitherData<String> verifyOtp(ForgotPasswordRequest request);

  EitherData<String> resetPassword(ForgotPasswordRequest request);
}
