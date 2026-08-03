import 'package:dio/dio.dart';

import '../../../core/api/api_client.dart';
import '../../../core/api/api_constants.dart';

class ProfileApiService {
  ProfileApiService._();

  static final ProfileApiService instance = ProfileApiService._();

  /*
  |--------------------------------------------------------------------------
  | Get Profile
  |--------------------------------------------------------------------------
  */

  Future<Map<String, dynamic>> getProfile() async {
    final Response response = await ApiClient.dio.get(ApiConstants.profile);

    return Map<String, dynamic>.from(response.data);
  }

  /*
  |--------------------------------------------------------------------------
  | Update Profile
  |--------------------------------------------------------------------------
  */

  Future<Map<String, dynamic>> updateProfile({
    required String fullName,
    String? email,
    String? phone,
  }) async {
    final Response response = await ApiClient.dio.put(
      ApiConstants.profile,
      data: {"full_name": fullName, "email": email, "phone": phone},
    );

    return Map<String, dynamic>.from(response.data);
  }

  /*
  |--------------------------------------------------------------------------
  | Upload Profile Picture
  |--------------------------------------------------------------------------
  */

  Future<Map<String, dynamic>> uploadProfilePhoto(String imagePath) async {
    final formData = FormData.fromMap({
      "file": await MultipartFile.fromFile(imagePath),
    });

    final Response response = await ApiClient.dio.post(
      ApiConstants.uploads,
      data: formData,
    );

    return Map<String, dynamic>.from(response.data);
  }

  /*
  |--------------------------------------------------------------------------
  | Change Password
  |--------------------------------------------------------------------------
  */

  Future<Map<String, dynamic>> changePassword({
    required String currentPassword,
    required String newPassword,
  }) async {
    final Response response = await ApiClient.dio.put(
      "${ApiConstants.profile}/change-password",
      data: {"current_password": currentPassword, "new_password": newPassword},
    );

    return Map<String, dynamic>.from(response.data);
  }

  /*
  |--------------------------------------------------------------------------
  | Delete Account
  |--------------------------------------------------------------------------
  */

  Future<Map<String, dynamic>> deleteAccount() async {
    final Response response = await ApiClient.dio.delete(ApiConstants.profile);

    return Map<String, dynamic>.from(response.data);
  }
}
