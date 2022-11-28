import 'package:pbp_e_03_flutter/authentication/models/email_validation_model.dart';
import 'package:pbp_e_03_flutter/authentication/models/registration_model.dart';
import 'package:pbp_e_03_flutter/shared/service/http_service.dart';

class AuthenticationService {
  static Future<EmailValidation> validateEmail(String email) async {
    Map<String, String> body = {"email": email};
    dynamic response = await HttpService.post("auth/email-validation", body);

    EmailValidation data = EmailValidation.fromJson(response);

    return data;
  }

  static Future<Registration> registerUser(Map<String, String> body) async {
    dynamic response = await HttpService.post("auth/registration", body);

    Registration data = Registration.fromJson(response);

    return data;
  }
}
