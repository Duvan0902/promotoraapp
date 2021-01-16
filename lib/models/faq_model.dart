import 'dart:convert';

class FaqModel {
  FaqModel({
    this.id,
    this.question,
    this.answer,
    this.faqCategories,
    this.createdAt,
    this.updatedAt,
  });

  final int id;
  final String question;
  final String answer;
  final int faqCategories;
  final DateTime createdAt;
  final DateTime updatedAt;

  factory FaqModel.fromJson(String str) => FaqModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory FaqModel.fromMap(Map<String, dynamic> json) => FaqModel(
        id: json["id"],
        question: json["question"],
        answer: json["answer"],
        faqCategories: json["faq_categories"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "question": question,
        "answer": answer,
        "faq_categories": faqCategories,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };
  @override
  String toString() => this.toJson();
}
