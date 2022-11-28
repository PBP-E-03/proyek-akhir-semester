// To parse this JSON data, do
//
//     final emailValidation = emailValidationFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

EmailValidation emailValidationFromJson(String str) =>
    EmailValidation.fromJson(json.decode(str));

String emailValidationToJson(EmailValidation data) =>
    json.encode(data.toJson());

class EmailValidation {
  EmailValidation({
    required this.success,
    this.content,
    required this.message,
  });

  bool success;
  Content? content;
  String message;

  factory EmailValidation.fromJson(Map<String, dynamic> json) =>
      EmailValidation(
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
    required this.isExist,
  });

  bool isExist;

  factory Content.fromJson(Map<String, dynamic> json) => Content(
        isExist: json["is_exist"],
      );

  Map<String, dynamic> toJson() => {
        "is_exist": isExist,
      };
}
