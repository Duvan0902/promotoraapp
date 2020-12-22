import 'dart:convert';

class AtacModel {
  AtacModel({
    this.id,
    this.atacCategory,
    this.atacSubcategories,
  });

  final int id;
  final String atacCategory;
  final List<AtacSubcategory> atacSubcategories;

  factory AtacModel.fromJson(String str) => AtacModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory AtacModel.fromMap(Map<String, dynamic> json) => AtacModel(
        id: json["id"],
        atacCategory: json["atac_category"],
        atacSubcategories: List<AtacSubcategory>.from(
            json["atac_subcategories"].map((x) => AtacSubcategory.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "atac_category": atacCategory,
        "atac_subcategories":
            List<dynamic>.from(atacSubcategories.map((x) => x.toMap())),
      };
}

class AtacSubcategory {
  AtacSubcategory({
    this.id,
    this.atacSubcategory,
  });

  final int id;
  final String atacSubcategory;

  factory AtacSubcategory.fromJson(String str) =>
      AtacSubcategory.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory AtacSubcategory.fromMap(Map<String, dynamic> json) => AtacSubcategory(
        id: json["id"],
        atacSubcategory: json["atac_subcategory"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "atac_subcategory": atacSubcategory,
      };
}
