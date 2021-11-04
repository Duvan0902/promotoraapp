import 'dart:convert';

import 'package:mi_promotora/models/user_model.dart';

class PortfolioModel {
  PortfolioModel({
    this.id,
    this.createdAt,
    this.updatedAt,
    this.customerName,
    this.insurance,
    this.policy,
    this.bill,
    this.phone,
    this.balance,
    this.customerId,
    this.contacted,
    this.agent,
  });

  int id;
  DateTime createdAt;
  DateTime updatedAt;
  String customerName;
  String insurance;
  String policy;
  String bill;
  String phone;
  String balance;
  String customerId;
  bool contacted;
  UserModel agent;

  factory PortfolioModel.fromJson(String str) =>
      PortfolioModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory PortfolioModel.fromMap(Map<String, dynamic> json) => PortfolioModel(
        id: json["id"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        customerName: json["customer_name"],
        insurance: json["insurance"],
        policy: json["policy"],
        bill: json["bill"],
        phone: json["phone"],
        balance: json["balance"],
        customerId: json["customer_id"],
        contacted: json["contacted"],
        agent: UserModel.fromMap(json["agent"]),
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "customer_name": customerName,
        "insurance": insurance,
        "policy": policy,
        "bill": bill,
        "phone": phone,
        "balance": balance,
        "customer_id": customerId,
        "contacted": contacted,
        "agent": agent.toMap(),
      };
}
