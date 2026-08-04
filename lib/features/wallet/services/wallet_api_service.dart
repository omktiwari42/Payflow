import 'package:dio/dio.dart';

import '../../../core/api/api_client.dart';
import '../../../core/api/api_constants.dart';

class WalletApiService {
  WalletApiService._();

  static final WalletApiService instance = WalletApiService._();

  /*
  |--------------------------------------------------------------------------
  | Wallet Details
  |--------------------------------------------------------------------------
  */

  Future<Map<String, dynamic>> getWallet() async {
    try {
      final Response response = await ApiClient.dio.get(ApiConstants.wallet);

      final data = Map<String, dynamic>.from(response.data);

      if (data["success"] != true) {
        throw Exception(data["message"] ?? "Unable to load wallet.");
      }

      return data;
    } on DioException catch (e) {
      throw Exception(
        e.response?.data?["message"]?.toString() ?? "Unable to load wallet.",
      );
    }
  }

  /*
  |--------------------------------------------------------------------------
  | Wallet Balance
  |--------------------------------------------------------------------------
  */

  Future<double> getBalance() async {
    final data = await getWallet();

    final wallet = Map<String, dynamic>.from(data["wallet"] ?? {});

    return double.tryParse(wallet["wallet_balance"].toString()) ?? 0.0;
  }

  /*
  |--------------------------------------------------------------------------
  | Add Money
  |--------------------------------------------------------------------------
  */

  Future<Map<String, dynamic>> addMoney(double amount) async {
    try {
      final Response response = await ApiClient.dio.post(
        "${ApiConstants.wallet}/add-money",
        data: {"amount": amount},
      );

      final data = Map<String, dynamic>.from(response.data);

      if (data["success"] != true) {
        throw Exception(data["message"] ?? "Unable to add money.");
      }

      return data;
    } on DioException catch (e) {
      throw Exception(
        e.response?.data?["message"]?.toString() ?? "Unable to add money.",
      );
    }
  }

  /*
  |--------------------------------------------------------------------------
  | Withdraw Money
  |--------------------------------------------------------------------------
  */

  Future<Map<String, dynamic>> withdraw(double amount) async {
    try {
      final Response response = await ApiClient.dio.post(
        "${ApiConstants.wallet}/withdraw",
        data: {"amount": amount},
      );

      final data = Map<String, dynamic>.from(response.data);

      if (data["success"] != true) {
        throw Exception(data["message"] ?? "Unable to withdraw money.");
      }

      return data;
    } on DioException catch (e) {
      throw Exception(
        e.response?.data?["message"]?.toString() ?? "Unable to withdraw money.",
      );
    }
  }

  /*
  |--------------------------------------------------------------------------
  | Wallet History
  |--------------------------------------------------------------------------
  */

  Future<List<Map<String, dynamic>>> history() async {
    try {
      final Response response = await ApiClient.dio.get(
        "${ApiConstants.wallet}/history",
      );

      final data = Map<String, dynamic>.from(response.data);

      if (data["success"] != true) {
        throw Exception(data["message"] ?? "Unable to load wallet history.");
      }

      return (data["transactions"] as List<dynamic>? ?? [])
          .map((e) => Map<String, dynamic>.from(e))
          .toList();
    } on DioException catch (e) {
      throw Exception(
        e.response?.data?["message"]?.toString() ??
            "Unable to load wallet history.",
      );
    }
  }
}
