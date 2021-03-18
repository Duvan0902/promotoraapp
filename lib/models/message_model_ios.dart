import 'dart:convert';

import 'package:mi_promotora/models/message_model.dart';

class MessageModelIos implements MessageModel {
  MessageModelIos({
    this.notification,
    this.clickAction,
    this.tapAction,
    this.tapActionArguments,
  });

  Notification notification;
  String clickAction;
  String tapAction;
  String tapActionArguments;

  Data get data => Data(
      clickAction: this.clickAction,
      tapAction: this.tapAction,
      tapActionArguments: this.tapActionArguments);

  set data(Data data) {
    this.clickAction = data.clickAction;
    this.tapAction = data.clickAction;
    this.tapActionArguments = data.tapActionArguments;
  }

  factory MessageModelIos.fromJson(String str) =>
      MessageModelIos.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory MessageModelIos.fromMap(Map<String, dynamic> json) => MessageModelIos(
        notification: json["notification"] == null
            ? null
            : Notification.fromMap(
                json["notification"].cast<String, dynamic>()),
        clickAction: json["click_action"] == null ? null : json["click_action"],
        tapAction: json["tap_action"] == null ? null : json["tap_action"],
        tapActionArguments: json["tap_action_arguments"] == null
            ? null
            : json["tap_action_arguments"],
      );

  Map<String, dynamic> toMap() => {
        "notification": notification == null ? null : notification.toMap(),
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
