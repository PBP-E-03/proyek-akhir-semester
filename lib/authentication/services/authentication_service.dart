import 'dart:convert';

import 'package:http/http.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:pbp_e_03_flutter/authentication/models/email_validation_model.dart';
import 'package:pbp_e_03_flutter/authentication/models/token_model.dart';
import 'package:pbp_e_03_flutter/shared/service/http_service.dart';
import 'package:pbp_e_03_flutter/shared/service/secure_storage_service.dart';
import 'package:http/http.dart' as http;

class AuthenticationService {
  static Future<EmailValidation> validateEmail(String email) async {
    Map<String, String> body = {"email": email};
    dynamic response = await HttpService.post("auth/email-validation", body,
        isAuthenticated: false);

    EmailValidation data = EmailValidation.fromJson(response);

    return data;
  }

  static Future<Token> registerUser(Map<String, String> body) async {
    dynamic response = await HttpService.post("auth/registration", body,
        isAuthenticated: false);

    Token data = Token.fromJson(response);

    return data;
  }

  static Future loginUser(Map<String, String> body) async {
    dynamic response =
        await HttpService.post("auth/login", body, isAuthenticated: false);

    return response;
  }

  static Future<dynamic> logoutUser() async {
    String? refreshToken = await SecureStorageService.read("refreshToken");

    Map<String, String> body = {"refresh": refreshToken!};

    dynamic response = await HttpService.post("auth/logout", body);

    return response;
  }

  static Future<bool> isAuthenticated() async {
    String? accessToken = await SecureStorageService.read("accessToken");

    if (accessToken != null) {
      Map<String, dynamic> decodedAccessToken = JwtDecoder.decode(accessToken);

      if (decodedAccessToken['exp'] * 1000 <
          DateTime.now().millisecondsSinceEpoch) {
        String? refreshToken = await SecureStorageService.read("refreshToken");

        if (refreshToken != null) {
          Map<String, dynamic> decodedRefreshToken =
              JwtDecoder.decode(refreshToken);

          if (decodedRefreshToken['exp'] * 1000 <
              DateTime.now().millisecondsSinceEpoch) {
            return false;
          }

          Map<String, String> body = {"refresh": refreshToken};

          Response response =
              await http.post(Uri.parse("http://localhost:8000/auth/refresh"),
                  headers: {
                    "Access-Control-Allow-Origin": "*",
                    "Content-Type": "application/json",
                  },
                  body: jsonEncode(body));

          dynamic data = jsonDecode(utf8.decode(response.bodyBytes));

          if (data['refresh'] == null || data['access'] == null) {
            return false;
          }

          await SecureStorageService.write("refreshToken", data['refresh']);
          await SecureStorageService.write("accessToken", data['access']);

          return true;
        }
        return false;
      }

      return true;
    } else {
      return false;
    }
  }
}
