import 'package:dio/dio.dart';

import '../../../core/api/api_client.dart';
import '../../../core/api/api_constants.dart';

class SettingsApiService {
  SettingsApiService._();

  static final SettingsApiService instance = SettingsApiService._();

  /*
  |--------------------------------------------------------------------------
  | Get Settings
  |--------------------------------------------------------------------------
  */

  Future<Map<String, dynamic>> getSettings() async {
    final Response response = await ApiClient.dio.get(ApiConstants.settings);

    return Map<String, dynamic>.from(response.data);
  }

  /*
  |--------------------------------------------------------------------------
  | Update Settings
  |--------------------------------------------------------------------------
  */

  Future<Map<String, dynamic>> updateSettings({
    required String theme,
    required String language,
    required bool notificationsEnabled,
    required bool biometricEnabled,
    required bool pinEnabled,
  }) async {
    final Response response = await ApiClient.dio.put(
      ApiConstants.settings,
      data: {
        "theme": theme,
        "language": language,
        "notifications_enabled": notificationsEnabled,
        "biometric_enabled": biometricEnabled,
        "pin_enabled": pinEnabled,
      },
    );

    return Map<String, dynamic>.from(response.data);
  }

  /*
  |--------------------------------------------------------------------------
  | Change Theme
  |--------------------------------------------------------------------------
  */

  Future<Map<String, dynamic>> changeTheme(String theme) async {
    final settings = await getSettings();

    final current = settings["settings"];

    return updateSettings(
      theme: theme,
      language: current["language"],
      notificationsEnabled: current["notifications_enabled"],
      biometricEnabled: current["biometric_enabled"],
      pinEnabled: current["pin_enabled"],
    );
  }

  /*
  |--------------------------------------------------------------------------
  | Logout All Devices
  |--------------------------------------------------------------------------
  */

  Future<Map<String, dynamic>> logoutAllDevices() async {
    final Response response = await ApiClient.dio.post(
      "${ApiConstants.settings}/logout-all",
    );

    return Map<String, dynamic>.from(response.data);
  }
}
