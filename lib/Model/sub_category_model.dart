import 'dart:convert';

class SubCategoryModel {
  SubCategoryModel({
    this.id,
    this.atacSubcategory,
  });

  final int id;
  final String atacSubcategory;

  factory SubCategoryModel.fromJson(String str) =>
      SubCategoryModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory SubCategoryModel.fromMap(Map<String, dynamic> json) =>
      SubCategoryModel(
        id: json["id"],
        atacSubcategory: json["atac_subcategory"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "atac_subcategory": atacSubcategory,
      };
}
