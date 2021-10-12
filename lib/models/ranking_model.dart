import 'dart:convert';

class RankingModel {
  RankingModel({
    this.insurance,
    this.data,
  });

  final String insurance;
  final List<RankingDataModel> data;

  factory RankingModel.fromJson(String str, String key) =>
      RankingModel.fromMap(json.decode(str), key);

  String toJson() => json.encode(toMap());

  factory RankingModel.fromMap(Map<String, dynamic> json, String insurance) =>
      RankingModel(
        data: List<RankingDataModel>.from(
            json[insurance].map((x) => RankingDataModel.fromMap(x))),
        insurance: insurance,
      );

  Map<String, dynamic> toMap() => {
        insurance: List<dynamic>.from(data.map((x) => x.toMap())),
      };
}

class RankingDataModel {
  RankingDataModel({
    this.id,
    this.userCode,
    this.name,
  });

  final int id;
  final String userCode;
  final String name;

  factory RankingDataModel.fromJson(String str) =>
      RankingDataModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory RankingDataModel.fromMap(Map<String, dynamic> json) =>
      RankingDataModel(
        id: json["id"],
        userCode: json["user_code"],
        name: json["name"] ?? '',
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "user_code": userCode,
        "name": name,
      };
}
