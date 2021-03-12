import 'dart:async';
import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:mi_promotora/models/message_model.dart';

class PushNotificationsProvider {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
  final _messageStreamController = StreamController<MessageModel>.broadcast();
  final _bgMessageStreamController = StreamController<MessageModel>.broadcast();

  Stream<MessageModel> get messageStreamm => _messageStreamController.stream;
  Stream<MessageModel> get backgroundMessageStreamm =>
      _bgMessageStreamController.stream;

  initNotifications() async {
    await _firebaseMessaging.requestNotificationPermissions();

    _firebaseMessaging.configure(
      onMessage: onMessage,
      onBackgroundMessage:
          Platform.isIOS ? null : PushNotificationsProvider.onBackgroundMessage,
      onLaunch: launch,
      onResume: onResume,
    );
  }

  static Future<dynamic> onBackgroundMessage(
      Map<String, dynamic> message) async {}

  Future<dynamic> launch(Map<String, dynamic> message) async {
    MessageModel receivedMessage = MessageModel.fromMap(message);
    print('Launch $receivedMessage');
    _bgMessageStreamController.add(receivedMessage);
  }

  Future<dynamic> onResume(Map<String, dynamic> message) async {
    MessageModel receivedMessage = MessageModel.fromMap(message);
    print('On resume: $receivedMessage');
    _bgMessageStreamController.add(receivedMessage);
  }

  Future<dynamic> onMessage(Map<String, dynamic> message) async {
    MessageModel receivedMessage = MessageModel.fromMap(message);
    print('On message $receivedMessage');
    _messageStreamController.add(receivedMessage);
  }

  void dispose() {
    _messageStreamController?.close();
    _bgMessageStreamController?.close();
  }
}
