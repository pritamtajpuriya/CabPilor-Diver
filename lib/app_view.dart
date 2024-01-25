import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:one_context/one_context.dart';
import 'config/app_theme.dart';
import 'config/application.dart';
import 'presentation/common_bloc/application/application_bloc.dart';
import 'presentation/common_bloc/auth/auth_bloc.dart';

import 'config/routes_manager.dart';
import 'constant/enum.dart';

class AppView extends StatefulWidget {
  const AppView({super.key});

  @override
  State<AppView> createState() => _AppViewState();
}

class _AppViewState extends State<AppView> {
  final _navigatorKey = GlobalKey<NavigatorState>();

  NavigatorState get _navigator => _navigatorKey.currentState!;
  void onNavigate(String route, {Object? arguments}) {
    // Navigation to Chat Screen
    OneContext()
        .navigator
        .key
        .currentState!
        .pushNamedAndRemoveUntil(route, (route) => false, arguments: arguments);
  }

  @override
  void initState() {
    // TODO: implement initState

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ApplicationBloc, ApplicationState>(
        builder: (context, applicationState) {
      return MaterialApp(
        navigatorKey: OneContext().navigator.key,
        debugShowCheckedModeBanner: Application.debug,
        title: Application.title,
        theme: appTheme,
        onGenerateRoute: AppRouter.generateRoute,
        builder: (context, child) {
          return BlocListener<AuthBloc, AuthState>(
              listener: (context, state) {
                switch (state.status) {
                  case AuthStatus.loading:
                    onNavigate(AppRouter.splash);
                    break;

                  case AuthStatus.categoryNotSetup:
                    onNavigate(AppRouter.landing);
                    break;

                  case AuthStatus.authenticated:
                    onNavigate(AppRouter.landing);
                    break;

                  case AuthStatus.unauthenticated:
                    onNavigate(AppRouter.login);
                    break;

                  case AuthStatus.unverified:
                    break;

                  case AuthStatus.profileNotSetup:
                    break;

                  case AuthStatus.appFirstOnboarded:
                    break;

                  default:
                    break;
                }
              },
              child: child!);
        },
      );
    });
  }
}
