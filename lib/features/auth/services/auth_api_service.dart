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
    final response = await ApiClient.dio.post(
      ApiConstants.login,
      data: {"identifier": identifier, "password": password},
    );

    final data = response.data;

    if (data["success"] == true && data["token"] != null) {
      await TokenStorage.saveToken(data["token"]);
    }

    return Map<String, dynamic>.from(data);
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
    final response = await ApiClient.dio.post(
      ApiConstants.register,
      data: {
        "full_name": fullName,
        "phone": phone,
        "email": email,
        "password": password,
      },
    );

    final data = response.data;

    if (data["success"] == true && data["token"] != null) {
      await TokenStorage.saveToken(data["token"]);
    }

    return Map<String, dynamic>.from(data);
  }

  /*
  |--------------------------------------------------------------------------
  | Send OTP
  |--------------------------------------------------------------------------
  */

  Future<Map<String, dynamic>> sendOtp(String phone) async {
    final response = await ApiClient.dio.post(
      ApiConstants.sendOtp,
      data: {"phone": phone},
    );

    return Map<String, dynamic>.from(response.data);
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
    final response = await ApiClient.dio.post(
      ApiConstants.verifyOtp,
      data: {"phone": phone, "otp": otp},
    );

    final data = response.data;

    if (data["success"] == true && data["token"] != null) {
      await TokenStorage.saveToken(data["token"]);
    }

    return Map<String, dynamic>.from(data);
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
    final response = await ApiClient.dio.post(
      ApiConstants.completeProfile,
      data: {"full_name": fullName, "email": email},
    );

    return Map<String, dynamic>.from(response.data);
  }

  /*
  |--------------------------------------------------------------------------
  | Logout
  |--------------------------------------------------------------------------
  */

  Future<void> logout() async {
    await TokenStorage.logout();
  }
}
