import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:mi_promotora/main.dart';
import 'package:mi_promotora/providers/push_notifications_provider.dart';

Future<void> manageNotifications(
    GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey) async {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();

  String token = await _firebaseMessaging.getToken();
  print('Device token: $token');

  final pushProvider = new PushNotificationsProvider();
  pushProvider.initNotifications();
  pushProvider.messageStreamm.listen((message) {
    print('Message received: $message');

    scaffoldMessengerKey.currentState.showSnackBar(SnackBar(
      backgroundColor: MiPromotora().accentLight,
      content: Text(message.notification.body),
      duration: Duration(seconds: 10),
      action: SnackBarAction(
        label: 'OK',
        textColor: MiPromotora().primary,
        disabledTextColor: MiPromotora().primary,
        onPressed: () {},
      ),
    ));
  });
}
