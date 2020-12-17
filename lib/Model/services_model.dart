import 'dart:convert';

class ServicesModel {
  ServicesModel({
    this.id,
    this.category,
    this.createdAt,
    this.updatedAt,
    this.icon,
    this.atac,
  });

  final int id;
  final String category;
  final DateTime createdAt;
  final DateTime updatedAt;
  final Icon icon;
  final List<dynamic> atac;

  factory ServicesModel.fromJson(String str) =>
      ServicesModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory ServicesModel.fromMap(Map<String, dynamic> json) => ServicesModel(
        id: json["id"],
        category: json["category"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        icon: Icon.fromMap(json["icon"]),
        atac: List<dynamic>.from(json["atac"].map((x) => x)),
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "category": category,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "icon": icon.toMap(),
        "atac": List<dynamic>.from(atac.map((x) => x)),
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
