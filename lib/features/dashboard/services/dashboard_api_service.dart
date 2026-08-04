import 'package:dio/dio.dart';

import '../../../core/api/api_client.dart';
import '../../../core/api/api_constants.dart';
import '../models/dashboard_model.dart';

class DashboardApiService {
  DashboardApiService._();

  static final DashboardApiService instance = DashboardApiService._();

  /*
  |--------------------------------------------------------------------------
  | Dashboard
  |--------------------------------------------------------------------------
  */

  Future<DashboardModel> getDashboard() async {
    try {
      final Response response = await ApiClient.dio.get(ApiConstants.dashboard);

      final Map<String, dynamic> data = Map<String, dynamic>.from(
        response.data,
      );

      return DashboardModel.fromJson(data);
    } on DioException catch (e) {
      throw Exception(
        e.response?.data["message"] ?? "Unable to load dashboard.",
      );
    }
  }

  /*
  |--------------------------------------------------------------------------
  | Helpers
  |--------------------------------------------------------------------------
  */

  Future<double> getWalletBalance() async {
    final dashboard = await getDashboard();
    return dashboard.walletBalance;
  }

  Future<double> getTotalSent() async {
    final dashboard = await getDashboard();
    return dashboard.totalSent;
  }

  Future<double> getTotalReceived() async {
    final dashboard = await getDashboard();
    return dashboard.totalReceived;
  }

  Future<int> getTotalTransactions() async {
    final dashboard = await getDashboard();
    return dashboard.totalTransactions;
  }

  Future<List<dynamic>> getRecentTransactions() async {
    final dashboard = await getDashboard();
    return dashboard.recentTransactions;
  }
}
