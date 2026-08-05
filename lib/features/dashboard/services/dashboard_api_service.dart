import 'package:dio/dio.dart';

import '../../../core/api/api_client.dart';
import '../../../core/api/api_constants.dart';
import '../models/dashboard_model.dart';

class DashboardApiService {
  DashboardApiService._();

  static final DashboardApiService instance = DashboardApiService._();

  Future<DashboardModel> getDashboard() async {
    try {
      final response = await ApiClient.dio.get(ApiConstants.dashboard);

      return DashboardModel.fromJson(Map<String, dynamic>.from(response.data));
    } on DioException catch (e) {
      print("============== DASHBOARD ERROR ==============");
      print("TYPE       : ${e.type}");
      print("MESSAGE    : ${e.message}");
      print("ERROR      : ${e.error}");
      print("URL        : ${e.requestOptions.uri}");
      print("HEADERS    : ${e.requestOptions.headers}");
      print("STATUS     : ${e.response?.statusCode}");
      print("BODY       : ${e.response?.data}");
      print("============================================");

      rethrow;
    }
  }

  Future<double> getWalletBalance() async =>
      (await getDashboard()).walletBalance;

  Future<double> getTotalSent() async => (await getDashboard()).totalSent;

  Future<double> getTotalReceived() async =>
      (await getDashboard()).totalReceived;

  Future<int> getTotalTransactions() async =>
      (await getDashboard()).totalTransactions;

  Future<List<dynamic>> getRecentTransactions() async =>
      (await getDashboard()).recentTransactions;
}
