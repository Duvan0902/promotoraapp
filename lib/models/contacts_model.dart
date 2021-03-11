import 'dart:convert';

import 'package:mi_promotora/models/contact_model_interface.dart';

class ContactsModel implements ContactModelInterface {
  ContactsModel({
    this.id,
    this.name,
    this.surname,
    this.company,
    this.email,
    this.phone1,
    this.phone2,
    this.description,
    this.createdAt,
    this.updatedAt,
    this.photo,
  });

  final int id;
  final String name;
  final String surname;
  final String company;
  final String email;
  final String phone1;
  final dynamic phone2;
  final String description;
  final DateTime createdAt;
  final DateTime updatedAt;
  final Photo photo;

  factory ContactsModel.fromJson(String str) =>
      ContactsModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory ContactsModel.fromMap(Map<String, dynamic> json) => ContactsModel(
        id: json["id"],
        name: json["name"],
        surname: json["surname"],
        company: json["company"],
        email: json["email"],
        phone1: json["phone1"],
        phone2: json["phone2"] == null ? null : json["phone2"],
        description: json["description"] == null ? null : json["description"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        photo: json["photo"] == null ? null : Photo.fromMap(json["photo"]),
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "name": name.toLowerCase(),
        "surname": surname.toLowerCase(),
        "company": company,
        "email": email,
        "phone1": phone1,
        "phone2": phone2,
        "description": description,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "photo": photo == null ? null : photo.toMap(),
      };

  @override
  String toString() {
    return this.toJson();
  }
}
