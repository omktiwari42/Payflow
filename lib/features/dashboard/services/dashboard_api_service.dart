import 'package:dio/dio.dart';

import '../../../core/api/api_client.dart';
import '../../../core/api/api_constants.dart';

class DashboardApiService {
  DashboardApiService._();

  static final DashboardApiService instance = DashboardApiService._();

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

  Map<String, dynamic> summary(Map<String, dynamic> dashboard) {
    return Map<String, dynamic>.from(dashboard["summary"] ?? {});
  }

  double getBalance(Map<String, dynamic> dashboard) {
    final s = summary(dashboard);

    return double.tryParse(s["walletBalance"].toString()) ?? 0;
  }

  double getIncome(Map<String, dynamic> dashboard) {
    final s = summary(dashboard);

    return double.tryParse(s["totalReceived"].toString()) ?? 0;
  }

  double getExpense(Map<String, dynamic> dashboard) {
    final s = summary(dashboard);

    return double.tryParse(s["totalSent"].toString()) ?? 0;
  }

  int totalTransactions(Map<String, dynamic> dashboard) {
    final s = summary(dashboard);

    return s["totalTransactions"] ?? 0;
  }

  List<dynamic> recentTransactions(Map<String, dynamic> dashboard) {
    final s = summary(dashboard);

    return List<dynamic>.from(s["recentTransactions"] ?? []);
  }

  List<Map<String, dynamic>> getRecentTransactions(
    Map<String, dynamic> dashboard,
  ) {
    final summary = Map<String, dynamic>.from(dashboard["summary"] ?? {});

    return (summary["recentTransactions"] as List<dynamic>? ?? [])
        .map((e) => Map<String, dynamic>.from(e))
        .toList();
  }
}
