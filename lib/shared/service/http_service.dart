import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:path/path.dart' as path;
import 'package:http/http.dart' as http;
import 'package:pbp_e_03_flutter/authentication/screens/login_screen.dart';
import 'package:pbp_e_03_flutter/authentication/services/authentication_service.dart';
import 'package:pbp_e_03_flutter/main.dart';
import 'package:pbp_e_03_flutter/shared/service/secure_storage_service.dart';

class HttpService {
  static const String _baseUrl = "https://api-generositree.up.railway.app";
  static final Map<String, String> headers = {
    "Content-Type": "application/json",
  };

  static Future get(String endpoint, {bool isAuthenticated = true}) async {
    Uri url = Uri.parse(path.join(_baseUrl, endpoint));

    await _authorizeHeader(isAuthenticated);

    Response response = await http.get(url, headers: headers);
    if (response.statusCode == 401 && endpoint != 'auth/login') {
      _handleUnauthorizedRequest();
    }

    return jsonDecode(utf8.decode(response.bodyBytes));
  }

  static Future post(String endpoint, Map<String, dynamic> body,
      {bool isAuthenticated = true}) async {
    Uri url = Uri.parse(path.join(_baseUrl, endpoint));

    await _authorizeHeader(isAuthenticated);

    Response response =
        await http.post(url, headers: headers, body: jsonEncode(body));

    if (response.statusCode == 401 && endpoint != 'auth/login') {
      _handleUnauthorizedRequest();
    }

    return jsonDecode(utf8.decode(response.bodyBytes));
  }

  static Future put(String endpoint, Map<String, dynamic> body,
      {bool isAuthenticated = true}) async {
    Uri url = Uri.parse(path.join(_baseUrl, endpoint));

    await _authorizeHeader(isAuthenticated);

    Response response =
        await http.put(url, headers: headers, body: jsonEncode(body));

    if (response.statusCode == 401 && endpoint != 'auth/login') {
      _handleUnauthorizedRequest();
    }

    return jsonDecode(utf8.decode(response.bodyBytes));
  }

  static Future<void> _authorizeHeader(bool isAuthenticated) async {
    if (isAuthenticated) {
      String? accessToken = await SecureStorageService.read("accessToken");

      if (await AuthenticationService.isAuthenticated()) {
        headers['Authorization'] = "Bearer $accessToken";
      } else {
        navigatorKey.currentState?.pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => LoginScreen()),
          (route) => false,
        );
      }
    }
  }

  static void _handleUnauthorizedRequest() async {
    await SecureStorageService.destroyAll();
    navigatorKey.currentState?.pushAndRemoveUntil(
      MaterialPageRoute(builder: (context) => LoginScreen()),
      (route) => false,
    );
  }
}
