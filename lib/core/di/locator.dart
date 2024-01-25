import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:readmock/presentation/pages/assigned/cubit/assigned_cubit.dart';
import 'package:readmock/presentation/pages/blog/cubit/blog_cubit.dart';
import 'package:readmock/presentation/pages/booklet/cubit/booklet_cubit.dart';
import 'package:readmock/presentation/pages/home/cubit/home_cubit.dart';
import 'package:readmock/presentation/pages/orders/cubit/order_cubit.dart';

import '../../data/repositories/data_repository_impl.dart';
import '../../domain/repository/data_repository.dart';
import '../../presentation/common_bloc/auth/auth_bloc.dart';
import '../../presentation/pages/customer/bloc/customer_cubit.dart';
import '../../presentation/pages/landing/bloc/landing_cubit/landing_cubit.dart';
import '../../presentation/pages/payment/cubit/payment_cubit.dart';
import '../../presentation/pages/profile/profile_bloc/profile_cubit.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../data/repositories/auth_repository_impl.dart';
import '../../domain/repository/auth_repository.dart';
import '../../presentation/common_bloc/application/application_bloc.dart';
import '../../presentation/pages/auth/blocs/forgot_password/forgot_password_cubit.dart';
import '../../presentation/pages/auth/blocs/login/login_bloc.dart';
import '../../presentation/pages/auth/blocs/register/register_bloc.dart';

import '../api/api.dart';

import '../networks/network_info.dart';
import '../utils/local_prefs.dart';

var getInstance = GetIt.instance;

Future<void>? initAppModule() async {
// Asyncronous registration

  final sharedPreferences = await SharedPreferences.getInstance();

  // SharedPreferences
  getInstance.registerLazySingleton<SharedPreferences>(() => sharedPreferences);

// dio
  getInstance.registerLazySingleton<Dio>(() => Api().dio);

  //NetworkInfo

  getInstance.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl());

// LocalPreferences
  getInstance.registerLazySingleton<LocalPrefs>(
      () => LocalPrefs(sharedPreferences: getInstance()));

// // Repository
  getInstance.registerLazySingleton<AuthRepository>(
      () => AuthRepositoryImpl(getInstance(), getInstance()));

// DataRepository
  getInstance.registerLazySingleton<DataRepository>(
      () => DataRepositoryImpl(getInstance(), getInstance()));

// Bloc
  initAllModule();
}

void initAllModule() {
  getInstance.registerLazySingleton<ApplicationBloc>(() => ApplicationBloc());
  getInstance.registerLazySingleton<AuthBloc>(
      () => AuthBloc(getInstance(), getInstance()));
  getInstance.registerFactory<LoginBloc>(
      () => LoginBloc(getInstance(), getInstance()));
  getInstance.registerFactory<RegisterBloc>(
      () => RegisterBloc(getInstance(), getInstance()));

  getInstance.registerFactory<LandingCubit>(() => LandingCubit());

  getInstance.registerFactory<ForgotPasswordCubit>(
      () => ForgotPasswordCubit(getInstance()));

  getInstance.registerFactory<ProfileCubit>(() => ProfileCubit());
  getInstance.registerFactory<CustomerCubit>(() => CustomerCubit(
        getInstance(),
      ));

  getInstance.registerFactory<BookletCubit>(() => BookletCubit(
        getInstance(),
      ));

  getInstance.registerFactory<BlogCubit>(() => BlogCubit(
        getInstance(),
      ));

  getInstance.registerFactory<PaymentCubit>(() => PaymentCubit(
        getInstance(),
      ));

  //Driver app
  getInstance.registerLazySingleton<HomeCubit>(() => HomeCubit(
        getInstance(),
      ));

  getInstance.registerLazySingleton<AssignedCubit>(() => AssignedCubit(
        getInstance(),
      ));

  getInstance.registerLazySingleton<OrderCubit>(() => OrderCubit(
        getInstance(),
      ));
}
