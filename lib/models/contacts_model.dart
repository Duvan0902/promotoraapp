import 'dart:convert';

class ContactsModel {
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
        phone2: json["phone2"],
        description: json["description"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
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
      };
}
