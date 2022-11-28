import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorageService {
  static const secureStorage = FlutterSecureStorage();

  static Future<void> write(String key, String value) async {
    await secureStorage.write(key: key, value: value);
  }

  static Future<String?> read(String key) async {
    String? value = await secureStorage.read(key: key);
    return value;
  }
}
