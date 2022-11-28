// To parse this JSON data, do
//
//     final registration = registrationFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

Registration registrationFromJson(String str) =>
    Registration.fromJson(json.decode(str));

String registrationToJson(Registration data) => json.encode(data.toJson());

class Registration {
  Registration({
    required this.success,
    this.content,
    required this.message,
  });

  bool success;
  Content? content;
  String message;

  factory Registration.fromJson(Map<String, dynamic> json) => Registration(
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
