import 'dart:convert';

import 'package:promotoraapp/Model/faq_model.dart';

class FaqCategoriesModel {
  FaqCategoriesModel({
    this.id,
    this.category,
    this.createdAt,
    this.updatedAt,
    this.faq,
  });

  final int id;
  final String category;
  final DateTime createdAt;
  final DateTime updatedAt;
  final List<FaqModel> faq;

  factory FaqCategoriesModel.fromJson(String str) =>
      FaqCategoriesModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory FaqCategoriesModel.fromMap(Map<String, dynamic> json) =>
      FaqCategoriesModel(
        id: json["id"],
        category: json["category"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        faq: List<FaqModel>.from(json["faq"].map((x) => FaqModel.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "category": category,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "faq": List<dynamic>.from(faq.map((x) => x.toMap())),
      };
  @override
  String toString() => this.toJson();
}
