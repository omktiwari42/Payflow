import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class AuthService {
  AuthService._();

  static final AuthService instance = AuthService._();

  static const String baseUrl = "http://10.0.2.2:5000/api";

  late final Dio _dio = Dio(
    BaseOptions(
      baseUrl: baseUrl,
      connectTimeout: const Duration(seconds: 20),
      receiveTimeout: const Duration(seconds: 20),
      headers: {
        "Content-Type": "application/json",
        "Accept": "application/json",
      },
    ),
  )..interceptors.add(LogInterceptor(requestBody: true, responseBody: true));

  final FlutterSecureStorage _storage = const FlutterSecureStorage();

  /*
  |--------------------------------------------------------------------------
  | Send OTP
  |--------------------------------------------------------------------------
  */

  Future<bool> sendOtp(String phone) async {
    try {
      debugPrint("📲 Sending OTP to $phone");

      final response = await _dio.post(
        "/auth/send-otp",
        data: {"phone": phone},
      );

      return response.data["success"] == true;
    } on DioException catch (e) {
      throw Exception(e.response?.data["message"] ?? "Failed to send OTP.");
    }
  }

  /*
  |--------------------------------------------------------------------------
  | Verify OTP
  |--------------------------------------------------------------------------
  */

  Future<Map<String, dynamic>> verifyOtp({
    required String phone,
    required String otp,
  }) async {
    try {
      debugPrint("🔐 Calling /auth/verify-otp");

      final response = await _dio.post(
        "/auth/verify-otp",
        data: {"phone": phone, "otp": otp},
      );

      if (response.data["token"] != null) {
        await saveToken(response.data["token"]);
      }

      return Map<String, dynamic>.from(response.data);
    } on DioException catch (e) {
      throw Exception(
        e.response?.data["message"] ?? "OTP verification failed.",
      );
    }
  }

  /*
  |--------------------------------------------------------------------------
  | Complete Profile
  |--------------------------------------------------------------------------
  */

  Future<Map<String, dynamic>> completeProfile({
    required String fullName,
    String? email,
  }) async {
    try {
      final token = await getToken();

      if (token == null || token.isEmpty) {
        throw Exception("Authentication token not found.");
      }

      final response = await _dio.post(
        "/auth/complete-profile",
        data: {"full_name": fullName, "email": email},
        options: Options(headers: {"Authorization": "Bearer $token"}),
      );

      return Map<String, dynamic>.from(response.data);
    } on DioException catch (e) {
      throw Exception(
        e.response?.data["message"] ?? "Failed to complete profile.",
      );
    }
  }

  /*
  |--------------------------------------------------------------------------
  | Token Storage
  |--------------------------------------------------------------------------
  */

  Future<void> saveToken(String token) async {
    await _storage.write(key: "jwt_token", value: token);
  }

  Future<String?> getToken() async {
    return _storage.read(key: "jwt_token");
  }

  Future<void> logout() async {
    await _storage.delete(key: "jwt_token");
  }

  Future<bool> isLoggedIn() async {
    final token = await getToken();

    return token != null && token.isNotEmpty;
  }

  /*
  |--------------------------------------------------------------------------
  | Current User
  |--------------------------------------------------------------------------
  */

  Future<Map<String, dynamic>?> getCurrentUser() async {
    final token = await getToken();

    if (token == null) {
      return null;
    }

    try {
      final parts = token.split(".");

      if (parts.length != 3) {
        return null;
      }

      final payload = utf8.decode(
        base64Url.decode(base64Url.normalize(parts[1])),
      );

      return jsonDecode(payload);
    } catch (_) {
      return null;
    }
  }
}
