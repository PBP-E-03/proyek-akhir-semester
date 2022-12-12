// To parse this JSON data, do
//
//     final history = historyFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

History historyFromJson(String str) => History.fromJson(json.decode(str));

String historyToJson(History data) => json.encode(data.toJson());

class History {
  History({
    required this.success,
    this.content,
    required this.message,
  });

  bool success;
  Content? content;
  String message;

  factory History.fromJson(Map<String, dynamic> json) => History(
        success: json["success"],
        content:
            json["content"] != null ? Content.fromJson(json["content"]) : null,
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "content": content!.toJson(),
        "message": message,
      };
}

class Content {
  Content({
    required this.donationHistory,
    required this.transactionHistory,
  });

  List<DonationHistory> donationHistory;
  List<TransactionHistory> transactionHistory;

  factory Content.fromJson(Map<String, dynamic> json) => Content(
        donationHistory: List<DonationHistory>.from(
            json["donation_history"].map((x) => DonationHistory.fromJson(x))),
        transactionHistory: List<TransactionHistory>.from(
            json["transaction_history"]
                .map((x) => TransactionHistory.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "donation_history":
            List<dynamic>.from(donationHistory.map((x) => x.toJson())),
        "transaction_history":
            List<dynamic>.from(transactionHistory.map((x) => x.toJson())),
      };
}

class DonationHistory {
  DonationHistory({
    required this.amount,
    required this.country,
    required this.date,
    this.person,
  });

  int amount;
  String country;
  DateTime date;
  String? person;

  factory DonationHistory.fromJson(Map<String, dynamic> json) =>
      DonationHistory(
        amount: json["amount"],
        country: json["country"],
        date: DateTime.parse(json["date"]),
        person: json["person"],
      );

  Map<String, dynamic> toJson() => {
        "amount": amount,
        "country": country,
        "date": date.toIso8601String(),
        "person": person,
      };
}

class TransactionHistory {
  TransactionHistory({
    required this.productName,
    required this.productAmount,
    required this.transactionAmount,
    required this.date,
  });

  String productName;
  int productAmount;
  int transactionAmount;
  DateTime date;

  factory TransactionHistory.fromJson(Map<String, dynamic> json) =>
      TransactionHistory(
        productName: json["product_name"],
        productAmount: json["product_amount"],
        transactionAmount: json["transaction_amount"],
        date: DateTime.parse(json["date"]),
      );

  Map<String, dynamic> toJson() => {
        "product_name": productName,
        "product_amount": productAmount,
        "transaction_amount": transactionAmount,
        "date": date.toIso8601String(),
      };
}
