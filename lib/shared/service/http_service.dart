import 'dart:convert';

import 'package:http/http.dart';
import 'package:path/path.dart' as path;
import 'package:http/http.dart' as http;

class HttpService {
  static const String baseUrl = "http://localhost:8000/";
  static final Map<String, String> headers = {
    "Access-Control-Allow-Origin": "*",
    "Content-Type": "application/json",
  };

  static Future get(String endpoint) async {
    Uri url = Uri.parse(path.join(baseUrl, endpoint));

    Response response = await http.get(url, headers: headers);

    return jsonDecode(utf8.decode(response.bodyBytes));
  }

  static Future post(String endpoint, Map<String, dynamic> body) async {
    Uri url = Uri.parse(path.join(baseUrl, endpoint));

    Response response =
        await http.post(url, headers: headers, body: jsonEncode(body));

    return jsonDecode(utf8.decode(response.bodyBytes));
  }
}
