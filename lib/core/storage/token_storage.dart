import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class TokenStorage {
  TokenStorage._();

  static const FlutterSecureStorage _storage = FlutterSecureStorage();

  static const String _tokenKey = "jwt_token";

  // ============================================================
  // SAVE JWT TOKEN
  // ============================================================

  static Future<void> saveToken(String token) async {
    final cleanToken = token.trim();

    if (cleanToken.isEmpty) {
      throw Exception("Cannot save an empty authentication token.");
    }

    await _storage.write(key: _tokenKey, value: cleanToken);

    final savedToken = await _storage.read(key: _tokenKey);

    if (savedToken == null || savedToken.trim() != cleanToken) {
      throw Exception("Failed to save authentication token.");
    }

    print("======================================");
    print("✅ TOKEN SAVED");
    print("Token length: ${cleanToken.length}");
    print("======================================");
  }

  // ============================================================
  // GET JWT TOKEN
  // ============================================================

  static Future<String?> getToken() async {
    final token = await _storage.read(key: _tokenKey);

    if (token == null || token.trim().isEmpty) {
      print("======================================");
      print("📖 TOKEN READ : NULL");
      print("======================================");

      return null;
    }

    final cleanToken = token.trim();

    print("======================================");
    print("📖 TOKEN READ");
    print("Token length: ${cleanToken.length}");
    print("======================================");

    return cleanToken;
  }

  // ============================================================
  // CHECK WHETHER TOKEN EXISTS
  // ============================================================

  static Future<bool> isLoggedIn() async {
    final token = await getToken();

    final loggedIn = token != null && token.isNotEmpty;

    print("======================================");
    print("🔐 IS LOGGED IN : $loggedIn");
    print("======================================");

    return loggedIn;
  }

  // ============================================================
  // DELETE JWT TOKEN
  // ============================================================

  static Future<void> deleteToken() async {
    await _storage.delete(key: _tokenKey);

    print("======================================");
    print("🗑 TOKEN DELETED");
    print("======================================");
  }

  // ============================================================
  // LOGOUT
  // ============================================================

  static Future<void> logout() async {
    await deleteToken();
  }

  // ============================================================
  // CLEAR ALL SECURE STORAGE
  // ============================================================

  static Future<void> clearAll() async {
    await _storage.deleteAll();

    print("======================================");
    print("🧹 SECURE STORAGE CLEARED");
    print("======================================");
  }
}
