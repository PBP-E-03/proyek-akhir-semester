// To parse this JSON data, do
//
//     final donation = donationFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

Donation donationFromJson(String str) => Donation.fromJson(json.decode(str));

String donationToJson(Donation data) => json.encode(data.toJson());

class Donation {
    Donation({
        required this.success,
        required this.content,
        required this.message,
    });

    bool success;
    dynamic content;
    String message;

    factory Donation.fromJson(Map<String, dynamic> json) => Donation(
        success: json["success"],
        content: json["content"],
        message: json["message"],
    );

    Map<String, dynamic> toJson() => {
        "success": success,
        "content": content,
        "message": message,
    };
}
