// To parse this JSON data, do
//
//     final messageModel = messageModelFromMap(jsonString);

import 'dart:convert';

class MessageModel {
  MessageModel({
    this.notification,
    this.data,
  });

  Notification notification;
  Data data;

  factory MessageModel.fromJson(String str) =>
      MessageModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory MessageModel.fromMap(Map<String, dynamic> json) => MessageModel(
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

class Data {
  Data({
    this.clickAction,
    this.tapAction,
    this.tapActionArguments,
  });

  String clickAction;
  String tapAction;
  String tapActionArguments;

  factory Data.fromJson(String str) => Data.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Data.fromMap(Map<String, dynamic> json) => Data(
        clickAction: json["click_action"] == null ? null : json["click_action"],
        tapAction: json["tap_action"] == null ? null : json["tap_action"],
        tapActionArguments: json["tap_action_arguments"] == null
            ? null
            : json["tap_action_arguments"],
      );

  Map<String, dynamic> toMap() => {
        "click_action": clickAction == null ? null : clickAction,
        "tap_action": tapAction == null ? null : tapAction,
        "tap_action_arguments":
            tapActionArguments == null ? null : tapActionArguments,
      };

  @override
  String toString() {
    return this.toJson();
  }
}

class Notification {
  Notification({
    this.title,
    this.body,
  });

  String title;
  String body;

  factory Notification.fromJson(String str) =>
      Notification.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Notification.fromMap(Map<String, dynamic> json) => Notification(
        title: json["title"] == null ? null : json["title"],
        body: json["body"] == null ? null : json["body"],
      );

  Map<String, dynamic> toMap() => {
        "title": title == null ? null : title,
        "body": body == null ? null : body,
      };

  @override
  String toString() {
    return this.toJson();
  }
}
