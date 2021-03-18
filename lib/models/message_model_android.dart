import 'dart:convert';

import 'package:mi_promotora/models/message_model.dart';

class MessageModelAndroid implements MessageModel {
  MessageModelAndroid({
    this.notification,
    this.data,
  });

  Notification notification;
  Data data;

  factory MessageModelAndroid.fromJson(String str) =>
      MessageModelAndroid.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory MessageModelAndroid.fromMap(Map<String, dynamic> json) =>
      MessageModelAndroid(
        notification: json["notification"] == null
            ? null
            : Notification.fromMap(
                json["notification"].cast<String, dynamic>()),
        data: json["data"] == null
            ? null
            : Data.fromMap(json["data"].cast<String, dynamic>()),
      );

  Map<String, dynamic> toMap() => {
        "notification": notification == null ? null : notification.toMap(),
        "data": data == null ? null : data.toMap(),
      };

  @override
  String toString() {
    return this.toJson();
  }
}
