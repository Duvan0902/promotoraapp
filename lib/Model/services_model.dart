import 'dart:convert';

class ServicesModel {
  ServicesModel({
    this.id,
    this.service,
    this.createdAt,
    this.updatedAt,
    this.icon,
    this.atacCategories,
  });

  final int id;
  final String service;
  final DateTime createdAt;
  final DateTime updatedAt;
  final Icon icon;
  final List<AtacCategory> atacCategories;

  factory ServicesModel.fromJson(String str) =>
      ServicesModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory ServicesModel.fromMap(Map<String, dynamic> json) => ServicesModel(
        id: json["id"],
        service: json["service"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        icon: Icon.fromMap(json["icon"]),
        atacCategories: List<AtacCategory>.from(
            json["atac_categories"].map((x) => AtacCategory.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "service": service,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "icon": icon.toMap(),
        "atac_categories":
            List<dynamic>.from(atacCategories.map((x) => x.toMap())),
      };
}

class AtacCategory {
  AtacCategory({
    this.id,
    this.category,
    this.atacService,
    this.createdAt,
    this.updatedAt,
  });

  final int id;
  final String category;
  final int atacService;
  final DateTime createdAt;
  final DateTime updatedAt;

  factory AtacCategory.fromJson(String str) =>
      AtacCategory.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory AtacCategory.fromMap(Map<String, dynamic> json) => AtacCategory(
        id: json["id"],
        category: json["category"],
        atacService: json["atac_service"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "category": category,
        "atac_service": atacService,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
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
