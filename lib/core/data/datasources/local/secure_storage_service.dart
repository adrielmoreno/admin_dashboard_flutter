import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorageService {
  static const _token = 'access_token';

  static AndroidOptions _getAndroidOptions() => const AndroidOptions(
        encryptedSharedPreferences: true,
      );

  static late FlutterSecureStorage storage;

  static Future<void> init() async {
    storage = FlutterSecureStorage(aOptions: _getAndroidOptions());
  }

  static Future<String?> getToken() async {
    return await _getString(_token);
  }

  static Future<void> saveToken(String value) async {
    return await _saveString(_token, value);
  }

  static Future<String?> _getString(String key) async {
    return await storage.read(key: key);
  }

  static Future<void> clear() async {
    return await storage.deleteAll();
  }

  static Future<void> _saveString(String key, String value) async {
    return await storage.write(key: key, value: value);
  }
}
