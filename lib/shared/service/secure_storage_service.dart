import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorageService {
  static const secureStorage = FlutterSecureStorage();

  static Future<void> write(String key, String value) async {
    await secureStorage.write(key: key, value: value);
  }

  static Future<String?> read(String key) async {
    return await secureStorage.read(key: key);
  }

  static Future<void> destroyAll() async {
    await secureStorage.deleteAll();
  }

  static Future<bool> has(String key) async {
    return await secureStorage.containsKey(key: key);
  }
}
