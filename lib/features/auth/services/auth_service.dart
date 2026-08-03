import '../../../core/storage/token_storage.dart';
import 'auth_api_service.dart';

class AuthService {
  AuthService._();

  static final AuthService instance = AuthService._();

  Future<bool> sendOtp(String phone) async {
    final response = await AuthApiService.instance.sendOtp(phone);
    return response["success"] == true;
  }

  Future<Map<String, dynamic>> verifyOtp({
    required String phone,
    required String otp,
  }) {
    return AuthApiService.instance.verifyOtp(phone: phone, otp: otp);
  }

  Future<Map<String, dynamic>> completeProfile({
    required String fullName,
    String? email,
  }) {
    return AuthApiService.instance.completeProfile(
      fullName: fullName,
      email: email,
    );
  }

  Future<bool> isLoggedIn() {
    return TokenStorage.isLoggedIn();
  }

  Future<String?> getToken() {
    return TokenStorage.getToken();
  }

  Future<void> saveToken(String token) {
    return TokenStorage.saveToken(token);
  }

  Future<void> logout() {
    return TokenStorage.logout();
  }
}
