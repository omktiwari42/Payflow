import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class TokenStorage {
  TokenStorage._();

  static const FlutterSecureStorage _storage = FlutterSecureStorage();

  static const String _tokenKey = "jwt_token";

  static Future<void> saveToken(String token) async {
    final cleanToken = token.trim();

    if (cleanToken.isEmpty) {
      throw Exception("Cannot save empty authentication token.");
    }

    await _storage.write(key: _tokenKey, value: cleanToken);
  }

  static Future<String?> getToken() async {
    final token = await _storage.read(key: _tokenKey);

    if (token == null || token.trim().isEmpty) {
      return null;
    }

    return token.trim();
  }

  static Future<void> deleteToken() async {
    await _storage.delete(key: _tokenKey);
  }

  static Future<bool> isLoggedIn() async {
    final token = await getToken();

    return token != null && token.isNotEmpty;
  }

  static Future<void> logout() async {
    await deleteToken();
  }

  static Future<void> clearAll() async {
    await _storage.deleteAll();
  }
}
