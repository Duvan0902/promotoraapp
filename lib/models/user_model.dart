import 'dart:convert';

class UserModel {
  UserModel({
    this.id,
    this.username,
    this.email,
    this.provider,
    this.confirmed,
    this.blocked,
    this.createdAt,
    this.updatedAt,
    this.name,
    this.surname,
    this.position,
    this.phone1,
    this.phone2,
    this.description,
    this.deviceToken,
    this.photo,
  });

  int id;
  String username;
  String email;
  String provider;
  bool confirmed;
  bool blocked;
  DateTime createdAt;
  DateTime updatedAt;
  String name;
  String surname;
  String position;
  String phone1;
  String phone2;
  String description;
  String deviceToken;
  Photo photo;

  factory UserModel.fromJson(String str) => UserModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory UserModel.fromMap(Map<String, dynamic> json) => UserModel(
        id: json["id"],
        username: json["username"],
        email: json["email"],
        provider: json["provider"],
        confirmed: json["confirmed"],
        blocked: json["blocked"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        name: json["name"],
        surname: json["surname"],
        position: json["position"],
        phone1: json["phone1"],
        phone2: json["phone2"] == null ? null : json["phone2"],
        description: json["description"] == null ? null : json["description"],
        deviceToken: json["device_token"] == null ? null : json["device_token"],
        photo: json["photo"] == null ? null : Photo.fromMap(json["photo"]),
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "username": username,
        "email": email,
        "provider": provider,
        "confirmed": confirmed,
        "blocked": blocked,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "name": name.toLowerCase(),
        "surname": surname,
        "position": position,
        "phone1": phone1,
        "phone2": phone2,
        "description": description == null ? null : description,
        "device_token": deviceToken == null ? null : deviceToken,
        "photo": photo == null ? null : photo.toMap(),
      };

  @override
  String toString() {
    return this.toJson();
  }
}

class Photo {
  Photo({
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

  int id;
  String name;
  String alternativeText;
  String caption;
  int width;
  int height;
  Formats formats;
  String hash;
  String ext;
  String mime;
  double size;
  String url;
  dynamic previewUrl;
  String provider;
  dynamic providerMetadata;
  DateTime createdAt;
  DateTime updatedAt;

  factory Photo.fromJson(String str) => Photo.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Photo.fromMap(Map<String, dynamic> json) => Photo(
        id: json["id"],
        name: json["name"],
        alternativeText: json["alternativeText"],
        caption: json["caption"],
        width: json["width"],
        height: json["height"],
        formats: Formats.fromMap(json["formats"]),
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
        "formats": formats.toMap(),
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

  @override
  String toString() {
    return this.toJson();
  }
}

class Formats {
  Formats({
    this.thumbnail,
    this.large,
    this.medium,
    this.small,
  });

  Format thumbnail;
  Format large;
  Format medium;
  Format small;

  factory Formats.fromJson(String str) => Formats.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Formats.fromMap(Map<String, dynamic> json) => Formats(
        thumbnail: json["thumbnail"] == null
            ? null
            : Format.fromMap(json["thumbnail"]),
        large: json["large"] == null ? null : Format.fromMap(json["large"]),
        medium: json["medium"] == null ? null : Format.fromMap(json["medium"]),
        small: json["small"] == null ? null : Format.fromMap(json["small"]),
      );

  Map<String, dynamic> toMap() => {
        "thumbnail": thumbnail == null ? null : thumbnail.toMap(),
        "large": large == null ? null : large.toMap(),
        "medium": medium == null ? null : medium.toMap(),
        "small": small == null ? null : small.toMap(),
      };

  @override
  String toString() {
    return this.toJson();
  }
}

class Format {
  Format({
    this.name,
    this.hash,
    this.ext,
    this.mime,
    this.width,
    this.height,
    this.size,
    this.path,
    this.url,
  });

  String name;
  String hash;
  String ext;
  String mime;
  int width;
  int height;
  double size;
  dynamic path;
  String url;

  factory Format.fromJson(String str) => Format.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Format.fromMap(Map<String, dynamic> json) => Format(
        name: json["name"],
        hash: json["hash"],
        ext: json["ext"],
        mime: json["mime"],
        width: json["width"],
        height: json["height"],
        size: json["size"].toDouble(),
        path: json["path"],
        url: json["url"],
      );

  Map<String, dynamic> toMap() => {
        "name": name,
        "hash": hash,
        "ext": ext,
        "mime": mime,
        "width": width,
        "height": height,
        "size": size,
        "path": path,
        "url": url,
      };

  @override
  String toString() {
    return this.toJson();
  }
}
