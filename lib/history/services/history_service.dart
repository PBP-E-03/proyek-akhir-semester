import 'package:pbp_e_03_flutter/history/models/history_model.dart';
import 'package:pbp_e_03_flutter/shared/service/http_service.dart';

class HistoryService {
  static Future<History> getHistory() async {
    try {
      dynamic response = await HttpService.get("history");
      History history = History.fromJson(response);
      return history;
    } catch (e) {
      return Future.error("Oops! Something went wrong");
    }
  }
}
