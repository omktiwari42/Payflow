import 'package:dio/dio.dart';

import '../../../core/api/api_client.dart';
import '../../../core/api/api_constants.dart';

class TransactionApiService {
  TransactionApiService._();

  static final TransactionApiService instance = TransactionApiService._();

  /*
  |--------------------------------------------------------------------------
  | Transaction History
  |--------------------------------------------------------------------------
  */

  Future<List<Map<String, dynamic>>> getTransactions() async {
    try {
      final Response response = await ApiClient.dio.get(
        ApiConstants.transactionHistory,
      );

      final data = Map<String, dynamic>.from(response.data);

      if (data["success"] != true) {
        throw Exception(data["message"] ?? "Unable to load transactions.");
      }

      return (data["transactions"] as List<dynamic>? ?? [])
          .map((e) => Map<String, dynamic>.from(e))
          .toList();
    } on DioException catch (e) {
      throw Exception(
        e.response?.data?["message"]?.toString() ??
            "Unable to load transactions.",
      );
    }
  }

  /*
  |--------------------------------------------------------------------------
  | Transaction Details
  |--------------------------------------------------------------------------
  */

  Future<Map<String, dynamic>> getTransaction(int id) async {
    try {
      final Response response = await ApiClient.dio.get(
        "${ApiConstants.transactionDetails}/$id",
      );

      return Map<String, dynamic>.from(response.data);
    } on DioException catch (e) {
      throw Exception(
        e.response?.data?["message"]?.toString() ??
            "Unable to load transaction.",
      );
    }
  }

  /*
  |--------------------------------------------------------------------------
  | Send Money
  |--------------------------------------------------------------------------
  */

  Future<Map<String, dynamic>> sendMoney({
    required String phone,
    required double amount,
    String note = "",
  }) async {
    try {
      final Response response = await ApiClient.dio.post(
        ApiConstants.sendMoney,
        data: {"phone": phone, "amount": amount, "note": note},
      );

      final data = Map<String, dynamic>.from(response.data);

      if (data["success"] != true) {
        throw Exception(data["message"] ?? "Money transfer failed.");
      }

      return data;
    } on DioException catch (e) {
      throw Exception(
        e.response?.data?["message"]?.toString() ?? "Money transfer failed.",
      );
    }
  }

  /*
  |--------------------------------------------------------------------------
  | Filter Transactions
  |--------------------------------------------------------------------------
  */

  Future<List<Map<String, dynamic>>> filter({
    String? type,
    String? from,
    String? to,
  }) async {
    try {
      final Response response = await ApiClient.dio.get(
        "${ApiConstants.transactions}/filter",
        queryParameters: {"type": type, "from": from, "to": to},
      );

      final data = Map<String, dynamic>.from(response.data);

      return (data["transactions"] as List<dynamic>? ?? [])
          .map((e) => Map<String, dynamic>.from(e))
          .toList();
    } on DioException catch (e) {
      throw Exception(
        e.response?.data?["message"]?.toString() ??
            "Unable to filter transactions.",
      );
    }
  }

  /*
  |--------------------------------------------------------------------------
  | Download Receipt
  |--------------------------------------------------------------------------
  */

  Future<String?> receipt(int transactionId) async {
    try {
      final Response response = await ApiClient.dio.get(
        "${ApiConstants.transactions}/$transactionId/receipt",
      );

      final data = Map<String, dynamic>.from(response.data);

      return data["url"]?.toString();
    } on DioException catch (e) {
      throw Exception(
        e.response?.data?["message"]?.toString() ??
            "Unable to download receipt.",
      );
    }
  }
}
