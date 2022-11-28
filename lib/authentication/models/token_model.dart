// To parse this JSON data, do
//
//     final token = tokenFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

Token tokenFromJson(String str) => Token.fromJson(json.decode(str));

String tokenToJson(Token data) => json.encode(data.toJson());

class Token {
  Token({
    required this.success,
    this.content,
    required this.message,
  });

  bool success;
  Content? content;
  String message;

  factory Token.fromJson(Map<String, dynamic> json) => Token(
        success: json["success"],
        content:
            json["content"] == null ? null : Content.fromJson(json["content"]),
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
    required this.refresh,
    required this.access,
  });

  String refresh;
  String access;

  factory Content.fromJson(Map<String, dynamic> json) => Content(
        refresh: json["refresh"],
        access: json["access"],
      );

  Map<String, dynamic> toJson() => {
        "refresh": refresh,
        "access": access,
      };
}
