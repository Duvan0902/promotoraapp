import 'dart:convert';

import 'package:mi_promotora/models/contact_model_interface.dart';

class UserModel implements ContactModelInterface {
  UserModel({
    this.id,
    this.username,
    this.email,
    this.provider,
    this.confirmed,
    this.blocked,
    this.createdAt,
    this.updatedAt,
    this.name,
    this.surname,
    this.company,
    this.phone1,
    this.phone2,
    this.description,
    this.deviceToken,
    this.photo,
    this.isEmployee,
  });

  int id;
  String username;
  String email;
  String provider;
  bool confirmed;
  bool blocked;
  DateTime createdAt;
  DateTime updatedAt;
  String name;
  String surname;
  String company;
  String phone1;
  String phone2;
  String description;
  String deviceToken;
  Photo photo;
  bool isEmployee;

  factory UserModel.fromJson(String str) => UserModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory UserModel.fromMap(Map<String, dynamic> json) => UserModel(
        id: json["id"],
        username: json["username"],
        email: json["email"],
        provider: json["provider"],
        confirmed: json["confirmed"],
        blocked: json["blocked"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        name: json["name"],
        surname: json["surname"],
        company: json["position"],
        phone1: json["phone1"],
        phone2: json["phone2"] == null ? null : json["phone2"],
        description: json["description"] == null ? null : json["description"],
        deviceToken: json["device_token"] == null ? null : json["device_token"],
        photo: json["photo"] == null ? null : Photo.fromMap(json["photo"]),
        isEmployee: json["is_employee"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "username": username,
        "email": email,
        "provider": provider,
        "confirmed": confirmed,
        "blocked": blocked,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "name": name.toLowerCase(),
        "surname": surname,
        "position": company,
        "phone1": phone1,
        "phone2": phone2,
        "description": description == null ? null : description,
        "device_token": deviceToken == null ? null : deviceToken,
        "photo": photo == null ? null : photo.toMap(),
        "is_employee": isEmployee,
      };

  @override
  String toString() {
    return this.toJson();
  }
}
