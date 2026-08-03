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

    final saved = await _storage.read(key: _tokenKey);

    print("======================================");
    print("✅ TOKEN SAVED");
    print(saved);
    print("======================================");
  }

  /*
  |--------------------------------------------------------------------------
  | Get JWT Token
  |--------------------------------------------------------------------------
  */

  static Future<String?> getToken() async {
    final token = await _storage.read(key: _tokenKey);

    print("======================================");
    print("📖 TOKEN READ");
    print(token);
    print("======================================");

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

    print("======================================");
    print("🗑 TOKEN DELETED");
    print("======================================");
  }

  /*
  |--------------------------------------------------------------------------
  | Check Login
  |--------------------------------------------------------------------------
  */

  static Future<bool> isLoggedIn() async {
    final token = await getToken();

    final loggedIn = token != null && token.isNotEmpty;

    print("======================================");
    print("🔐 IS LOGGED IN : $loggedIn");
    print("======================================");

    return loggedIn;
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
  | Clear Secure Storage
  |--------------------------------------------------------------------------
  */

  static Future<void> clearAll() async {
    await _storage.deleteAll();

    print("======================================");
    print("🧹 SECURE STORAGE CLEARED");
    print("======================================");
  }
}
