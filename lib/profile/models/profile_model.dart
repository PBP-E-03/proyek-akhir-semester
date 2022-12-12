// To parse this JSON data, do
//
//     final profile = profileFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

Profile profileFromJson(String str) => Profile.fromJson(json.decode(str));

String profileToJson(Profile data) => json.encode(data.toJson());

class Profile {
  Profile({
    required this.success,
    this.content,
    required this.message,
  });

  bool success;
  Content? content;
  String message;

  factory Profile.fromJson(Map<String, dynamic> json) => Profile(
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
    required this.username,
    required this.email,
    required this.phone,
    required this.address,
  });

  String username;
  String email;
  String phone;
  String address;

  factory Content.fromJson(Map<String, dynamic> json) => Content(
        username: json["username"],
        email: json["email"],
        phone: json["phone"],
        address: json["address"],
      );

  Map<String, dynamic> toJson() => {
        "username": username,
        "email": email,
        "phone": phone,
        "address": address,
      };
}
