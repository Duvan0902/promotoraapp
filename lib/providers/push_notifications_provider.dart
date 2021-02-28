import 'dart:async';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:mi_promotora/models/message_model.dart';

class PushNotificationsProvider {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
  final _messageStreamController = StreamController<MessageModel>.broadcast();

  Stream<MessageModel> get messageStreamm => _messageStreamController.stream;

  initNotifications() async {
    await _firebaseMessaging.requestNotificationPermissions();

    _firebaseMessaging.configure(
      onMessage: onMessage,
      onBackgroundMessage: onBackgroundMessage,
      onLaunch: launch,
      onResume: onResume,
    );
  }

  static Future<dynamic> onBackgroundMessage(
      Map<String, dynamic> message) async {}

  Future<dynamic> launch(Map<String, dynamic> message) async {
    MessageModel receivedMessage = MessageModel.fromMap(message);
    _messageStreamController.add(receivedMessage);
  }

  Future<dynamic> onResume(Map<String, dynamic> message) async {
    MessageModel receivedMessage = MessageModel.fromMap(message);
    _messageStreamController.add(receivedMessage);
  }

  Future<dynamic> onMessage(Map<String, dynamic> message) async {
    MessageModel receivedMessage = MessageModel.fromMap(message);
    _messageStreamController.add(receivedMessage);
  }

  void dispose() {
    _messageStreamController?.close();
  }
}
