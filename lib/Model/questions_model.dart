import 'dart:convert';

import 'package:promotoraapp/Model/faq_model.dart';

class QuestionsModel {
  QuestionsModel({
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

  factory QuestionsModel.fromJson(String str) =>
      QuestionsModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory QuestionsModel.fromMap(Map<String, dynamic> json) => QuestionsModel(
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
