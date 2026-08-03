import 'package:dio/dio.dart';

import '../../../core/api/api_client.dart';
import '../../../core/api/api_constants.dart';
import '../../../core/storage/token_storage.dart';

class AuthApiService {
  AuthApiService._();

  static final AuthApiService instance = AuthApiService._();

  /*
  |--------------------------------------------------------------------------
  | Login
  |--------------------------------------------------------------------------
  */

  Future<Map<String, dynamic>> login({
    required String identifier,
    required String password,
  }) async {
    try {
      final Response response = await ApiClient.dio.post(
        ApiConstants.login,
        data: {"identifier": identifier.trim(), "password": password},
      );

      final Map<String, dynamic> data = Map<String, dynamic>.from(
        response.data,
      );

      if (data["success"] == true && data["token"] != null) {
        await TokenStorage.saveToken(data["token"]);
      }

      return data;
    } on DioException catch (e) {
      throw Exception(
        e.response?.data["message"] ?? "Unable to login. Please try again.",
      );
    }
  }

  /*
  |--------------------------------------------------------------------------
  | Register
  |--------------------------------------------------------------------------
  */

  Future<Map<String, dynamic>> register({
    required String fullName,
    required String phone,
    String? email,
    required String password,
  }) async {
    try {
      final Response response = await ApiClient.dio.post(
        ApiConstants.register,
        data: {
          "full_name": fullName.trim(),
          "phone": phone.trim(),
          "email": email?.trim(),
          "password": password,
        },
      );

      final Map<String, dynamic> data = Map<String, dynamic>.from(
        response.data,
      );

      if (data["success"] == true && data["token"] != null) {
        await TokenStorage.saveToken(data["token"]);
      }

      return data;
    } on DioException catch (e) {
      throw Exception(e.response?.data["message"] ?? "Registration failed.");
    }
  }

  /*
  |--------------------------------------------------------------------------
  | Send OTP
  |--------------------------------------------------------------------------
  */

  Future<Map<String, dynamic>> sendOtp(String phone) async {
    try {
      final Response response = await ApiClient.dio.post(
        ApiConstants.sendOtp,
        data: {"phone": phone.trim()},
      );

      return Map<String, dynamic>.from(response.data);
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
      final Response response = await ApiClient.dio.post(
        ApiConstants.verifyOtp,
        data: {"phone": phone.trim(), "otp": otp.trim()},
      );

      final Map<String, dynamic> data = Map<String, dynamic>.from(
        response.data,
      );

      if (data["success"] == true && data["token"] != null) {
        await TokenStorage.saveToken(data["token"]);
      }

      return data;
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
      final Response response = await ApiClient.dio.post(
        ApiConstants.completeProfile,
        data: {"full_name": fullName.trim(), "email": email?.trim()},
      );

      return Map<String, dynamic>.from(response.data);
    } on DioException catch (e) {
      throw Exception(
        e.response?.data["message"] ?? "Failed to update profile.",
      );
    }
  }

  /*
  |--------------------------------------------------------------------------
  | Logout
  |--------------------------------------------------------------------------
  */

  Future<void> logout() async {
    await TokenStorage.logout();
  }

  /*
  |--------------------------------------------------------------------------
  | Check Login
  |--------------------------------------------------------------------------
  */

  Future<bool> isLoggedIn() async {
    final token = await TokenStorage.getToken();
    return token != null && token.isNotEmpty;
  }

  /*
  |--------------------------------------------------------------------------
  | Get Token
  |--------------------------------------------------------------------------
  */

  Future<String?> getToken() async {
    return await TokenStorage.getToken();
  }
}
