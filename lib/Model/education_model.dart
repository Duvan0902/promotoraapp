import 'dart:convert';

class EducationModel {
  EducationModel({
    this.id,
    this.module,
    this.videoUrl,
    this.createdAt,
    this.updatedAt,
    this.documentFiles,
    this.podcastFile,
    this.icon,
  });

  final int id;
  final String module;
  final String videoUrl;
  final DateTime createdAt;
  final DateTime updatedAt;
  final List<DocumentFile> documentFiles;
  final EducationIcon podcastFile;
  final EducationIcon icon;

  factory EducationModel.fromJson(String str) =>
      EducationModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory EducationModel.fromMap(Map<String, dynamic> json) => EducationModel(
        id: json["id"],
        module: json["module"],
        videoUrl: json["video_url"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        documentFiles: List<DocumentFile>.from(
            json["document_files"].map((x) => DocumentFile.fromMap(x))),
        podcastFile: EducationIcon.fromMap(json["podcast_file"]),
        icon: EducationIcon.fromMap(json["icon"]),
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "module": module,
        "video_url": videoUrl,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "document_files":
            List<dynamic>.from(documentFiles.map((x) => x.toMap())),
        "podcast_file": podcastFile.toMap(),
        "icon": icon.toMap(),
      };
}

class DocumentFile {
  DocumentFile({
    this.id,
    this.title,
    this.file,
  });

  final int id;
  final String title;
  final EducationIcon file;

  factory DocumentFile.fromJson(String str) =>
      DocumentFile.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory DocumentFile.fromMap(Map<String, dynamic> json) => DocumentFile(
        id: json["id"],
        title: json["title"],
        file: EducationIcon.fromMap(json["file"]),
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "title": title,
        "file": file.toMap(),
      };
}

class EducationIcon {
  EducationIcon({
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

  factory EducationIcon.fromJson(String str) =>
      EducationIcon.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory EducationIcon.fromMap(Map<String, dynamic> json) => EducationIcon(
        id: json["id"],
        name: json["name"],
        alternativeText: json["alternativeText"],
        caption: json["caption"],
        width: json["width"] == null ? null : json["width"],
        height: json["height"] == null ? null : json["height"],
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
        "width": width == null ? null : width,
        "height": height == null ? null : height,
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
