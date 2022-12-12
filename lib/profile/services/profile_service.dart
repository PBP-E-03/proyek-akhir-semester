import 'package:pbp_e_03_flutter/profile/models/profile_model.dart';
import 'package:pbp_e_03_flutter/shared/service/http_service.dart';

class ProfileService {
  static Future<Profile> getProfile() async {
    try {
      dynamic response = await HttpService.get("profile");
      Profile userProfile = Profile.fromJson(response);
      return userProfile;
    } catch (e) {
      return Future.error("Oops! Something went wrong");
    }
  }

  static Future<Profile> updateProfile(Map<String, String> body) async {
    try {
      dynamic response = await HttpService.put("profile/update", body);

      Profile userProfile = Profile.fromJson(response);

      return userProfile;
    } catch (e) {
      return Future.error("Oops! Something went wrong");
    }
  }

  static Future<dynamic> changePassword(Map<String, String> body) async {
    try {
      dynamic response = await HttpService.put("profile/update-password", body);

      return response;
    } catch (e) {
      return Future.error("Oops! Something went wrong");
    }
  }
}
