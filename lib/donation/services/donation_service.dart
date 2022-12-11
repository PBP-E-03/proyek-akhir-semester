
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:http/http.dart';
import 'package:http/http.dart' as http;
import 'package:pbp_e_03_flutter/shared/service/http_service.dart';


class DonationService {
  static Future<List<String>> getCountries() async {
    dynamic response = await HttpService.get("location");
    // print(response);

    dynamic data = response;
    
    dynamic countries_data = data["content"]["countries"];
    // print(countries_data);
    

    List<String> countries = [];
    for (var element in countries_data) {
      // print(element);
      countries.add(element["name"]);
    }

    // print(countries);
    return countries;

    
  }

  static Future<File> pickFile() async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(type: FileType.custom, allowedExtensions: ['png', 'jpg', 'jpeg']);
      late File file;

      if(result!=null) {
        String path = result.files.first.path!;
        file = File(path);
      }

      return file;
    } catch(e) {
      throw e;
    }
    
  }

  
}