import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class TokenStorage {
  TokenStorage._();

  static const FlutterSecureStorage _storage = FlutterSecureStorage();

  static const String _tokenKey = "jwt_token";

  /*
  |--------------------------------------------------------------------------
  | Save JWT Token
  |--------------------------------------------------------------------------
  */

  static Future<void> saveToken(String token) async {
    if (token.trim().isEmpty) return;

    await _storage.write(key: _tokenKey, value: token.trim());
  }

  /*
  |--------------------------------------------------------------------------
  | Get JWT Token
  |--------------------------------------------------------------------------
  */

  static Future<String?> getToken() async {
    final token = await _storage.read(key: _tokenKey);

    if (token == null || token.trim().isEmpty) {
      return null;
    }

    return token.trim();
  }

  /*
  |--------------------------------------------------------------------------
  | Delete JWT Token
  |--------------------------------------------------------------------------
  */

  static Future<void> deleteToken() async {
    await _storage.delete(key: _tokenKey);
  }

  /*
  |--------------------------------------------------------------------------
  | Check Login
  |--------------------------------------------------------------------------
  */

  static Future<bool> isLoggedIn() async {
    return (await getToken()) != null;
  }

  /*
  |--------------------------------------------------------------------------
  | Logout
  |--------------------------------------------------------------------------
  */

  static Future<void> logout() async {
    await deleteToken();
  }

  /*
  |--------------------------------------------------------------------------
  | Clear All Secure Storage
  |--------------------------------------------------------------------------
  */

  static Future<void> clearAll() async {
    await _storage.deleteAll();
  }
}
