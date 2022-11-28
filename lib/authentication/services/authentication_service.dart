import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:pbp_e_03_flutter/authentication/models/email_validation_model.dart';
import 'package:pbp_e_03_flutter/authentication/models/token_model.dart';
import 'package:pbp_e_03_flutter/shared/service/http_service.dart';
import 'package:pbp_e_03_flutter/shared/service/secure_storage_service.dart';

class AuthenticationService {
  static Future<EmailValidation> validateEmail(String email) async {
    Map<String, String> body = {"email": email};
    dynamic response = await HttpService.post("auth/email-validation", body);

    EmailValidation data = EmailValidation.fromJson(response);

    return data;
  }

  static Future<Token> registerUser(Map<String, String> body) async {
    dynamic response = await HttpService.post("auth/registration", body);

    Token data = Token.fromJson(response);

    return data;
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

          dynamic response = await HttpService.post("auth/refresh", body);

          if (response['refresh'] == null || response['access'] == null) {
            return false;
          }

          await SecureStorageService.write("refreshToken", response['refresh']);
          await SecureStorageService.write("accessToken", response['access']);

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
