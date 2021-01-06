import 'dart:convert';

class DocumentsModel {
  DocumentsModel({
    this.id,
    this.title,
    this.createdAt,
    this.updatedAt,
    this.file,
  });

  final int id;
  final String title;
  final DateTime createdAt;
  final DateTime updatedAt;
  final List<FileElement> file;

  factory DocumentsModel.fromJson(String str) =>
      DocumentsModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory DocumentsModel.fromMap(Map<String, dynamic> json) => DocumentsModel(
        id: json["id"],
        title: json["title"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        file: List<FileElement>.from(
            json["file"].map((x) => FileElement.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "title": title,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "file": List<dynamic>.from(file.map((x) => x.toMap())),
      };
}

class FileElement {
  FileElement({
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
  final dynamic width;
  final dynamic height;
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

  factory FileElement.fromJson(String str) =>
      FileElement.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory FileElement.fromMap(Map<String, dynamic> json) => FileElement(
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
