import 'package:dio/dio.dart';

import '../../../core/api/api_client.dart';
import '../../../core/api/api_constants.dart';

class DashboardApiService {
  DashboardApiService._();

  static final DashboardApiService instance = DashboardApiService._();

  /*
  |--------------------------------------------------------------------------
  | Dashboard Data
  |--------------------------------------------------------------------------
  */

  Future<Map<String, dynamic>> getDashboard() async {
    final Response response = await ApiClient.dio.get(ApiConstants.dashboard);

    return Map<String, dynamic>.from(response.data);
  }

  /*
  |--------------------------------------------------------------------------
  | Wallet Balance
  |--------------------------------------------------------------------------
  */

  Future<double> getBalance() async {
    final dashboard = await getDashboard();

    return (dashboard["wallet_balance"] ?? 0).toDouble();
  }

  /*
  |--------------------------------------------------------------------------
  | Monthly Income
  |--------------------------------------------------------------------------
  */

  Future<double> getIncome() async {
    final dashboard = await getDashboard();

    return (dashboard["income"] ?? 0).toDouble();
  }

  /*
  |--------------------------------------------------------------------------
  | Monthly Expense
  |--------------------------------------------------------------------------
  */

  Future<double> getExpense() async {
    final dashboard = await getDashboard();

    return (dashboard["expense"] ?? 0).toDouble();
  }

  /*
  |--------------------------------------------------------------------------
  | Recent Transactions
  |--------------------------------------------------------------------------
  */

  Future<List<dynamic>> recentTransactions() async {
    final dashboard = await getDashboard();

    return dashboard["recent_transactions"] ?? [];
  }

  /*
  |--------------------------------------------------------------------------
  | Upcoming Bills
  |--------------------------------------------------------------------------
  */

  Future<List<dynamic>> upcomingBills() async {
    final dashboard = await getDashboard();

    return dashboard["upcoming_bills"] ?? [];
  }

  /*
  |--------------------------------------------------------------------------
  | Notifications
  |--------------------------------------------------------------------------
  */

  Future<List<dynamic>> notifications() async {
    final dashboard = await getDashboard();

    return dashboard["notifications"] ?? [];
  }
}
