// To parse this JSON data, do
//
//     final user = userFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

User userFromJson(String str) => User.fromJson(json.decode(str));

String userToJson(User data) => json.encode(data.toJson());

class User {
  User({
    required this.success,
    this.content,
    required this.message,
  });

  bool success;
  Content? content;
  String message;

  factory User.fromJson(Map<String, dynamic> json) => User(
        success: json["success"],
        content: Content.fromJson(json["content"]),
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
    required this.name,
    required this.email,
    required this.coin,
    required this.totalDonatedTree,
    required this.mostDonatedCountry,
  });

  String name;
  String email;
  int coin;
  int totalDonatedTree;
  String mostDonatedCountry;

  factory Content.fromJson(Map<String, dynamic> json) => Content(
        name: json["name"],
        email: json["email"],
        coin: json["coin"],
        totalDonatedTree: json["total_donated_tree"],
        mostDonatedCountry: json["most_donated_country"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "email": email,
        "coin": coin,
        "total_donated_tree": totalDonatedTree,
        "most_donated_country": mostDonatedCountry,
      };
}
