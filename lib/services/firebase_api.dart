import 'dart:convert';

import 'package:fashion_guru/screens/order_details_screen.dart';
import 'package:fashion_guru/screens/view_orders.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import '../controllers/session.dart';
import '../screens/product_detail_screen.dart';

class FirebaseApi {
  GlobalKey<NavigatorState> navigatorKey;
  FirebaseApi(this.navigatorKey);

  final _firebaseMessaging = FirebaseMessaging.instance;
  final _androidChannel = const AndroidNotificationChannel(
    'high_importance_channel',
    'High Importance Notifications',
    importance: Importance.high,
  );
  final InitializationSettings initializationSettings = InitializationSettings(
    android: AndroidInitializationSettings('@drawable/ic_launcher'),
  );

  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  Future<void> initNotifications() async {
    await _firebaseMessaging.requestPermission();
    final fcmToken = await _firebaseMessaging.getToken();
    setDataToLocalStorage('fcm_token', fcmToken!);

    FirebaseMessaging.onBackgroundMessage(handleBackgroundMessage);
    FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
      print(message.notification?.title);
      await flutterLocalNotificationsPlugin.initialize(initializationSettings,
          onDidReceiveNotificationResponse: onSelectNotification);
      await flutterLocalNotificationsPlugin.show(
          message.messageId.hashCode,
          message.notification?.title,
          message.notification?.body,
          payload: jsonEncode(message.data),
          NotificationDetails(
              android: AndroidNotificationDetails(
                  _androidChannel.id, _androidChannel.name,
                  icon: '@drawable/ic_launcher')));
    });
    FirebaseMessaging.onMessageOpenedApp.listen((message) {
      onSelectNotification(jsonEncode(message.data));
    });
  }

  void onSelectNotification(details) async {
    Map<String, dynamic> payload = jsonDecode(details.payload ?? "{}");
    if (payload['route'] == 'OrderDetails') {
      navigatorKey.currentState?.push(MaterialPageRoute(
          builder: (context) => OrderDetailScreen(id: payload['order_id'])));
    } else if (payload['route'] == 'ViewOrder'){
      navigatorKey.currentState?.push(MaterialPageRoute(
          builder: (context) => ViewOrders()));
    }
  }

  Future<void> handleBackgroundMessage(RemoteMessage message) async {
    print("${message.data}");
  }

}



