import 'dart:convert';

import 'package:promotoraapp/Model/atac_model.dart';

class ServicesModel {
  ServicesModel({
    this.id,
    this.name,
    this.createdAt,
    this.updatedAt,
    this.atacCategories,
    this.icon,
  });

  final int id;
  final String name;
  final DateTime createdAt;
  final DateTime updatedAt;
  final List<AtacModel> atacCategories;
  final Icon icon;

  factory ServicesModel.fromJson(String str) =>
      ServicesModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory ServicesModel.fromMap(Map<String, dynamic> json) => ServicesModel(
        id: json["id"],
        name: json["name"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        atacCategories: List<AtacModel>.from(
            json["atac_categories"].map((x) => AtacModel.fromMap(x))),
        icon: Icon.fromMap(json["icon"]),
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "name": name,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "atac_categories":
            List<dynamic>.from(atacCategories.map((x) => x.toMap())),
        "icon": icon.toMap(),
      };
}

class AtacCategory {
  AtacCategory({
    this.id,
    this.atacCategory,
    this.atacSubcategories,
  });

  final int id;
  final String atacCategory;
  final List<AtacSubcategory> atacSubcategories;

  factory AtacCategory.fromJson(String str) =>
      AtacCategory.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory AtacCategory.fromMap(Map<String, dynamic> json) => AtacCategory(
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
        atacSubcategory:
            json["atac_subcategory"] == null ? null : json["atac_subcategory"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "atac_subcategory": atacSubcategory == null ? null : atacSubcategory,
      };
}

class Icon {
  Icon({
    this.id,
    this.name,
    this.alternativeText,
    this.caption,
    this.width,
    this.height,
    this.formats,
    this.hash,
    this.ext,
    this.mime,
    this.size,
    this.url,
    this.previewUrl,
    this.provider,
    this.providerMetadata,
    this.createdAt,
    this.updatedAt,
  });

  final int id;
  final String name;
  final String alternativeText;
  final String caption;
  final int width;
  final int height;
  final dynamic formats;
  final String hash;
  final String ext;
  final String mime;
  final double size;
  final String url;
  final dynamic previewUrl;
  final String provider;
  final dynamic providerMetadata;
  final DateTime createdAt;
  final DateTime updatedAt;

  factory Icon.fromJson(String str) => Icon.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Icon.fromMap(Map<String, dynamic> json) => Icon(
        id: json["id"],
        name: json["name"],
        alternativeText: json["alternativeText"],
        caption: json["caption"],
        width: json["width"],
        height: json["height"],
        formats: json["formats"],
        hash: json["hash"],
        ext: json["ext"],
        mime: json["mime"],
        size: json["size"].toDouble(),
        url: json["url"],
        previewUrl: json["previewUrl"],
        provider: json["provider"],
        providerMetadata: json["provider_metadata"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "name": name,
        "alternativeText": alternativeText,
        "caption": caption,
        "width": width,
        "height": height,
        "formats": formats,
        "hash": hash,
        "ext": ext,
        "mime": mime,
        "size": size,
        "url": url,
        "previewUrl": previewUrl,
        "provider": provider,
        "provider_metadata": providerMetadata,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };
}
