import 'dart:convert';

class GoalsModel {
  GoalsModel({
    this.id,
    this.userCode,
    this.name,
    this.branchGct,
    this.pdnNew,
    this.pdnNewPrev,
    this.pdnTotal,
    this.pdnCanc,
    this.pctEffect,
    this.avgPrima,
    this.integratedReport,
    this.createdAt,
    this.updatedAt,
  });

  final int id;
  final String userCode;
  final String name;
  final String branchGct;
  final String pdnNew;
  final String pdnNewPrev;
  final String pdnTotal;
  final String pdnCanc;
  final double pctEffect;
  final String avgPrima;
  final IntegratedReport integratedReport;
  final DateTime createdAt;
  final DateTime updatedAt;

  factory GoalsModel.fromJson(String str) =>
      GoalsModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory GoalsModel.fromMap(Map<String, dynamic> json) => GoalsModel(
        id: json["id"],
        userCode: json["user_code"],
        name: json["name"],
        branchGct: json["branch_gct"],
        pdnNew: json["pdn_new"],
        pdnNewPrev: json["pdn_new_prev"],
        pdnTotal: json["pdn_total"],
        pdnCanc: json["pdn_canc"],
        pctEffect: json["pct_effect"].toDouble(),
        avgPrima: json["avg_prima"],
        integratedReport: IntegratedReport.fromMap(json["integrated_report"]),
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "user_code": userCode,
        "name": name,
        "branch_gct": branchGct,
        "pdn_new": pdnNew,
        "pdn_new_prev": pdnNewPrev,
        "pdn_total": pdnTotal,
        "pdn_canc": pdnCanc,
        "pct_effect": pctEffect,
        "avg_prima": avgPrima,
        "integrated_report": integratedReport.toMap(),
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };
}

class IntegratedReport {
  IntegratedReport({
    this.id,
    this.createdAt,
    this.updatedAt,
    this.file,
  });

  final int id;
  final DateTime createdAt;
  final DateTime updatedAt;
  final FileClass file;

  factory IntegratedReport.fromJson(String str) =>
      IntegratedReport.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory IntegratedReport.fromMap(Map<String, dynamic> json) =>
      IntegratedReport(
        id: json["id"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        file: FileClass.fromMap(json["file"]),
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "file": file.toMap(),
      };
}

class FileClass {
  FileClass({
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

  factory FileClass.fromJson(String str) => FileClass.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory FileClass.fromMap(Map<String, dynamic> json) => FileClass(
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
