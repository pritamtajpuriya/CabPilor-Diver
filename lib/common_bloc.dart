import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:readmock/presentation/pages/assigned/cubit/assigned_cubit.dart';
import 'package:readmock/presentation/pages/blog/cubit/blog_cubit.dart';
import 'package:readmock/presentation/pages/booklet/cubit/booklet_cubit.dart';
import 'package:readmock/presentation/pages/customer/bloc/customer_cubit.dart';
import 'package:readmock/presentation/pages/home/cubit/home_cubit.dart';
import 'package:readmock/presentation/pages/orders/cubit/order_cubit.dart';
import 'package:readmock/presentation/pages/payment/cubit/payment_cubit.dart';

import 'core/di/locator.dart';
import 'presentation/common_bloc/application/application_bloc.dart';
import 'presentation/common_bloc/auth/auth_bloc.dart';
import 'presentation/pages/auth/blocs/login/login_bloc.dart';
import 'presentation/pages/auth/blocs/register/register_bloc.dart';
import 'presentation/pages/landing/bloc/landing_cubit/landing_cubit.dart';
import 'presentation/pages/profile/profile_bloc/profile_cubit.dart';

class CommonBloc {
  static final List<BlocProvider> blocProviders = [
    BlocProvider<ApplicationBloc>(
        create: (context) => getInstance<ApplicationBloc>()),
    BlocProvider<AuthBloc>(
        create: (context) => getInstance<AuthBloc>()..add(AuthCheck())),
    BlocProvider<LoginBloc>(create: (context) => getInstance<LoginBloc>()),
    BlocProvider<RegisterBloc>(
        create: (context) => getInstance<RegisterBloc>()),
    BlocProvider<LandingCubit>(create: (context) {
      return getInstance<LandingCubit>();
    }),
    BlocProvider<ProfileCubit>(
        create: (context) => getInstance<ProfileCubit>()..getUser()),

    // BlocProvider<CustomerCubit>(
    //   create: (context) => getInstance<CustomerCubit>()..getCustomers(),
    // ),
    // BlocProvider<BookletCubit>(
    //     create: (context) => getInstance<BookletCubit>()
    //       ..getBooklets()
    //       ..getPaymentTerms()),
    // BlocProvider<BlogCubit>(
    //     create: (context) => getInstance<BlogCubit>()..getBlogs()),

    // //payment Cubit
    // BlocProvider<PaymentCubit>(
    //     create: (context) => getInstance<PaymentCubit>()..getPayments()),

    //Driver app

    BlocProvider<HomeCubit>(create: (context) => getInstance<HomeCubit>()),

    //Order
    BlocProvider<OrderCubit>(create: (context) => getInstance<OrderCubit>()),

    BlocProvider<AssignedCubit>(
        create: (context) => getInstance<AssignedCubit>()..getTripsList()),
  ];
}
