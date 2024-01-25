import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:readmock/service/local_notification.dart';

import 'app_view.dart';
import 'common_bloc.dart';
import 'config/size_config.dart';
import 'core/di/locator.dart';

Future<void> backgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  if (message.notification != null) {}
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await initAppModule();
  setupFirebase();

  runApp(const MyApp());
}

//Firebase initialization
void setupFirebase() async {
  await Firebase.initializeApp();
  await LocalNotificationService().setUpFirebaseNotification();
  FirebaseMessaging.onBackgroundMessage(backgroundHandler);
}

void setupApp() async {}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: CommonBloc.blocProviders,
      child: LayoutBuilder(
        builder: (context, constraints) {
          return OrientationBuilder(
            builder: (context, orientation) {
              SizeConfig().init(constraints, orientation);
              return const AppView();
            },
          );
        },
      ),
    );
  }
}
