import 'dart:convert';
import 'dart:developer';

import 'package:app_settings/app_settings.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:one_context/one_context.dart';
import 'package:readmock/core/di/locator.dart';
import 'package:readmock/domain/model/order.dart';
import 'package:readmock/presentation/pages/orders/cubit/order_cubit.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../presentation/widgets/custom_exit_card.dart';
import '../presentation/widgets/order_bottom_sheet.dart';

class LocalNotificationService {
  static final FlutterLocalNotificationsPlugin _notificationsPlugin =
      FlutterLocalNotificationsPlugin();

  setUpFirebaseNotification() async {
    //SharePreference
    SharedPreferences pref = await SharedPreferences.getInstance();
    //initialize the plugin
    log('setUpFirebaseNotification');
    await initialize();
    await requestNotificationPermissions();
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification?.android;
      if (notification != null && android != null) {
        //print message payload
        log('A new onMessage event was published!');
        log(message.data.toString());
        // log(jsonEncode(message.data));

        try {
          if (message.data['type'] == 'order') {
            getInstance<OrderCubit>()
                .setOrders(orderFromJson(message.data['data']));
            showModalBottomSheet(
                backgroundColor: Colors.transparent,
                context: OneContext().navigator.key.currentState!.context,
                builder: (_) => OderBottomSheet(
                      order: orderFromJson(message.data['data']),
                    ));
          } else {
            createanddisplaynotification(message);
          }
        } on Exception catch (e) {
          log(e.toString());
        }
      }
    });

    //Print fcm token
    await FirebaseMessaging.instance.getToken().then((token) {
      log('FirebaseMessaging token: $token');
      pref.setString('fcm-token', token!);
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      log('A new onMessageOpenedApp event was published!');
      createanddisplaynotification(message);
    });

    // FirebaseMessaging.onBackgroundMessage((message) async {
    //   log('A new onBackgroundMessage event was published!');
    //   createanddisplaynotification(message);
    // });

    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );
  }

  initialize() async {
    // initializationSettings  for Android

    final AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings("@mipmap/ic_launcher");

    // IoS settings

    final DarwinInitializationSettings initializationSettingsDarwom =
        DarwinInitializationSettings(
            requestAlertPermission: true,
            requestBadgePermission: true,
            requestSoundPermission: true,
            requestCriticalPermission: true,
            onDidReceiveLocalNotification: onDidReceiveLocalNotification);

    InitializationSettings initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsDarwom,
    );

    await _notificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: onSelectNotification,
    );
  }

//   OnSelectNotificationCallback? get callback => null;
  Future onSelectNotification(
    NotificationResponse notification,
  ) async {
    log('onDidReceiveNotificationResponse');

    if (notification.payload != null) {
      log(notification.payload.toString());
      final json = jsonDecode(notification.payload!);
      log('user click');
      // Navigation to Chat Screen
      // OneContext().navigator.key.currentState!.push(MaterialPageRoute(
      //     builder: (context) => Chat(
      //           userId: int.parse(json['user_id']),
      //           chatId: int.parse(json['chat_id']),
      //           name: json['name'],
      //         )));
      // if (json['type'] == 'category') {
      //   log('category');
      //   Get.toNamed(Routes.category, arguments: ['notification', json['id']]);
      // }
    }
  }

  void onDidReceiveLocalNotification(
    int id,
    String? title,
    String? body,
    String? payload,
  ) async {
    // display a dialog with the notification details, tap ok to go to another page
  }

  static void createanddisplaynotification(RemoteMessage message) async {
    try {
      final id = DateTime.now().millisecondsSinceEpoch ~/ 1000;
      const NotificationDetails notificationDetails = NotificationDetails(
        android: AndroidNotificationDetails(
          "cabpilotDriver",
          "pushnotificationappchannel",
          // sound

          importance: Importance.max,
          priority: Priority.high,
        ),
      );

      await _notificationsPlugin.show(
        id,
        message.notification!.title,
        message.notification!.body,
        notificationDetails,
        payload: jsonEncode(message.data),
      );
    } on Exception catch (e) {
      log(e.toString());
    }
  }

  //  void requestNotificationPermissions() {

  static requestNotificationPermissions() async {
    NotificationSettings setting =
        await FirebaseMessaging.instance.requestPermission(
      sound: true,
      announcement: true,
      badge: true,
      alert: true,
      carPlay: true,
      provisional: true,
      criticalAlert: true,
    );
    if (setting.authorizationStatus == AuthorizationStatus.authorized) {
      log('User granted permission');
    } else if (setting.authorizationStatus == AuthorizationStatus.provisional) {
      log('User granted provisional permission');
    } else {
      AppSettings.openAppSettings();
      log('User declined or has not accepted permission');
    }
  }

  static void requestIOSPermissions() {
    _notificationsPlugin
        .resolvePlatformSpecificImplementation<
            IOSFlutterLocalNotificationsPlugin>()
        ?.requestPermissions(
          alert: true,
          badge: true,
          sound: true,
        );
  }
}
