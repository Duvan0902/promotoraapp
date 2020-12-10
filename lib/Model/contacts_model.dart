import 'dart:convert';

class ContactsModel {
  ContactsModel({
    this.url,
    this.title,
    this.description,
    this.type,
  });

  String url;
  String title;
  String description;
  String type;

  factory ContactsModel.fromJson(String str) =>
      ContactsModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory ContactsModel.fromMap(Map<String, dynamic> json) => ContactsModel(
        url: json["url"],
        title: json["title"],
        description: json["description"],
        type: json["type"],
      );

  Map<String, dynamic> toMap() => {
        "url": url,
        "title": title,
        "description": description,
        "type": type,
      };
}
