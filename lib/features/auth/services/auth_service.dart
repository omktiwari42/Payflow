import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class AuthService {
  AuthService._();

  static final AuthService instance = AuthService._();

  // Change this before production deployment.
  // Android Emulator -> 10.0.2.2
  // iOS Simulator -> localhost
  // Physical Device -> Your PC's Local IP
  // Production -> https://api.yourdomain.com

  static const String baseUrl = "http://10.0.2.2:5000/api";

  final Dio _dio = Dio(
    BaseOptions(
      baseUrl: baseUrl,
      connectTimeout: const Duration(seconds: 20),
      receiveTimeout: const Duration(seconds: 20),
      headers: {
        "Content-Type": "application/json",
        "Accept": "application/json",
      },
    ),
  );

  final FlutterSecureStorage _storage =
  const FlutterSecureStorage();

  Future<bool> sendOtp(String phone) async {
    try {
      final response = await _dio.post(
        "/auth/send-otp",
        data: {
          "phone": phone,
        },
      );

      return response.data["success"] == true;
    } on DioException catch (e) {
      throw Exception(
        e.response?.data["message"] ??
            "Failed to send OTP.",
      );
    }
  }

  Future<Map<String, dynamic>> verifyOtp({
    required String phone,
    required String otp,
  }) async {
    try {
      final response = await _dio.post(
        "/auth/verify-otp",
        data: {
          "phone": phone,
          "otp": otp,
        },
      );

      if (response.data["token"] != null) {
        await saveToken(response.data["token"]);
      }

      return response.data;
    } on DioException catch (e) {
      throw Exception(
        e.response?.data["message"] ??
            "OTP verification failed.",
      );
    }
  }

  Future<void> completeProfile({
    required String fullName,
    required String email,
  }) async {
    final token = await getToken();

    await _dio.post(
      "/auth/complete-profile",
      data: {
        "full_name": fullName,
        "email": email,
      },
      options: Options(
        headers: {
          "Authorization": "Bearer $token",
        },
      ),
    );
  }

  Future<void> saveToken(String token) async {
    await _storage.write(
      key: "jwt_token",
      value: token,
    );
  }

  Future<String?> getToken() async {
    return _storage.read(
      key: "jwt_token",
    );
  }

  Future<void> logout() async {
    await _storage.delete(
      key: "jwt_token",
    );
  }

  Future<bool> isLoggedIn() async {
    final token = await getToken();

    return token != null && token.isNotEmpty;
  }

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
        base64Url.decode(
          base64Url.normalize(parts[1]),
        ),
      );

      return jsonDecode(payload);
    } catch (_) {
      return null;
    }
  }
}