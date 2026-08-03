import 'package:dio/dio.dart';

import '../../../core/api/api_client.dart';
import '../../../core/api/api_constants.dart';

class DashboardApiService {
  DashboardApiService._();

  static final DashboardApiService instance = DashboardApiService._();

  /*
  |--------------------------------------------------------------------------
  | Dashboard
  |--------------------------------------------------------------------------
  */

  Future<Map<String, dynamic>> getDashboard() async {
    try {
      final Response response = await ApiClient.dio.get(ApiConstants.dashboard);

      return Map<String, dynamic>.from(response.data);
    } on DioException catch (e) {
      throw Exception(
        e.response?.data["message"] ?? "Unable to load dashboard.",
      );
    }
  }

  /*
  |--------------------------------------------------------------------------
  | Dashboard Helpers
  |--------------------------------------------------------------------------
  */

  double getBalance(Map<String, dynamic> dashboard) {
    return (dashboard["wallet_balance"] ?? 0).toDouble();
  }

  double getIncome(Map<String, dynamic> dashboard) {
    return (dashboard["income"] ?? 0).toDouble();
  }

  double getExpense(Map<String, dynamic> dashboard) {
    return (dashboard["expense"] ?? 0).toDouble();
  }

  List<dynamic> recentTransactions(Map<String, dynamic> dashboard) {
    return List<dynamic>.from(dashboard["recent_transactions"] ?? []);
  }

  List<dynamic> upcomingBills(Map<String, dynamic> dashboard) {
    return List<dynamic>.from(dashboard["upcoming_bills"] ?? []);
  }

  List<dynamic> notifications(Map<String, dynamic> dashboard) {
    return List<dynamic>.from(dashboard["notifications"] ?? []);
  }
}
