// To parse this JSON data, do
//
//     final salesCategoryModel = salesCategoryModelFromMap(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

List<SalesCategoryModel> salesCategoryModelFromMap(String str) =>
    List<SalesCategoryModel>.from(
        json.decode(str).map((x) => SalesCategoryModel.fromMap(x)));

String salesCategoryModelToMap(List<SalesCategoryModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toMap())));

class SalesCategoryModel {
  SalesCategoryModel({
    @required this.id,
    @required this.title,
    @required this.description,
    @required this.createdAt,
    @required this.updatedAt,
    @required this.icon,
    @required this.sales,
  });

  final int id;
  final String title;
  final String description;
  final DateTime createdAt;
  final DateTime updatedAt;
  final IconModel icon;
  final List<SaleModel> sales;

  factory SalesCategoryModel.fromMap(Map<String, dynamic> json) =>
      SalesCategoryModel(
        id: json["id"],
        title: json["title"],
        description: json["description"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        icon: json["icon"] == null ? null : IconModel.fromMap(json["icon"]),
        sales: List<SaleModel>.from(
            json["sales"].map((x) => SaleModel.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "title": title,
        "description": description,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "icon": icon == null ? null : icon.toMap(),
        "sales": List<dynamic>.from(sales.map((x) => x.toMap())),
      };
}

class IconModel {
  IconModel({
    @required this.id,
    @required this.name,
    @required this.alternativeText,
    @required this.caption,
    @required this.width,
    @required this.height,
    @required this.formats,
    @required this.hash,
    @required this.ext,
    @required this.mime,
    @required this.size,
    @required this.url,
    @required this.previewUrl,
    @required this.provider,
    @required this.providerMetadata,
    @required this.createdAt,
    @required this.updatedAt,
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

  factory IconModel.fromMap(Map<String, dynamic> json) => IconModel(
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

class SaleModel {
  SaleModel({
    @required this.id,
    @required this.date,
    @required this.value,
    @required this.client,
    @required this.idClient,
    @required this.user,
    @required this.createdAt,
    @required this.updatedAt,
    @required this.category,
  });

  final int id;
  final DateTime date;
  final double value;
  final String client;
  final String idClient;
  final int user;
  final DateTime createdAt;
  final DateTime updatedAt;
  final int category;

  factory SaleModel.fromMap(Map<String, dynamic> json) {
    var category = json["category"];
    if (category != null) {
      category = category.runtimeType == int ? category : category["id"];
    }

    var user = json["user"];
    user = user.runtimeType == int ? user : user["id"];

    return SaleModel(
      id: json["id"],
      date: DateTime.parse(json["date"]),
      value: double.tryParse(json["value"]) ?? 0,
      client: json["client"],
      idClient: json["id_client"],
      user: user,
      createdAt: DateTime.parse(json["created_at"]),
      updatedAt: DateTime.parse(json["updated_at"]),
      category: category,
    );
  }

  Map<String, dynamic> toMap() => {
        "id": id,
        "date":
            "${date.year.toString().padLeft(4, '0')}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}",
        "value": value,
        "client": client,
        "id_client": idClient,
        "user": user,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "category": category,
      };
}
