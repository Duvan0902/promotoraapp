import 'dart:convert';

class UsersModel {
  UsersModel({
    this.id,
    this.name,
    this.description,
    this.type,
    this.createdAt,
    this.updatedAt,
    this.surname,
    this.position,
    this.phone1,
    this.phone2,
  });

  final int id;
  final String name;
  final String description;
  final String type;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String surname;
  final String position;
  final String phone1;
  final String phone2;

  factory UsersModel.fromJson(String str) =>
      UsersModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory UsersModel.fromMap(Map<String, dynamic> json) => UsersModel(
        id: json["id"],
        name: json["name"],
        description: json["description"],
        type: json["type"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        surname: json["surname"],
        position: json["position"],
        phone1: json["phone1"],
        phone2: json["phone2"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "name": name,
        "description": description,
        "type": type,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "surname": surname,
        "position": position,
        "phone1": phone1,
        "phone2": phone2,
      };
}
