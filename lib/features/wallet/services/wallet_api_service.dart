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
    final Response response = await ApiClient.dio.get(ApiConstants.wallet);

    return Map<String, dynamic>.from(response.data);
  }

  /*
  |--------------------------------------------------------------------------
  | Wallet Balance
  |--------------------------------------------------------------------------
  */

  Future<double> getBalance() async {
    final data = await getWallet();

    if (data["wallet"] == null) {
      return 0;
    }

    return (data["wallet"]["wallet_balance"] as num).toDouble();
  }

  /*
  |--------------------------------------------------------------------------
  | Add Money
  |--------------------------------------------------------------------------
  */

  Future<Map<String, dynamic>> addMoney(double amount) async {
    final Response response = await ApiClient.dio.post(
      "${ApiConstants.wallet}/add-money",
      data: {"amount": amount},
    );

    return Map<String, dynamic>.from(response.data);
  }

  /*
  |--------------------------------------------------------------------------
  | Withdraw Money
  |--------------------------------------------------------------------------
  */

  Future<Map<String, dynamic>> withdraw(double amount) async {
    final Response response = await ApiClient.dio.post(
      "${ApiConstants.wallet}/withdraw",
      data: {"amount": amount},
    );

    return Map<String, dynamic>.from(response.data);
  }

  /*
  |--------------------------------------------------------------------------
  | Wallet History
  |--------------------------------------------------------------------------
  */

  Future<List<dynamic>> history() async {
    final Response response = await ApiClient.dio.get(
      "${ApiConstants.wallet}/history",
    );

    return response.data["transactions"] ?? [];
  }
}
