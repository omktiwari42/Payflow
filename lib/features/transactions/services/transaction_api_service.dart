import 'package:dio/dio.dart';

import '../../../core/api/api_client.dart';
import '../../../core/api/api_constants.dart';

class TransactionApiService {
  TransactionApiService._();

  static final TransactionApiService instance = TransactionApiService._();

  // ============================================================
  // TRANSACTION HISTORY
  // ============================================================

  Future<List<Map<String, dynamic>>> getTransactions() async {
    try {
      final Response response = await ApiClient.dio.get(
        ApiConstants.transactionHistory,
      );

      final data = Map<String, dynamic>.from(response.data);

      if (data["success"] != true) {
        throw Exception(data["message"] ?? "Unable to load transactions.");
      }

      final transactions = data["transactions"];

      if (transactions is! List) {
        return [];
      }

      return transactions
          .whereType<Map>()
          .map((item) => Map<String, dynamic>.from(item))
          .toList();
    } on DioException catch (e) {
      throw Exception(
        e.response?.data?["message"]?.toString() ??
            "Unable to load transactions.",
      );
    }
  }

  // ============================================================
  // TRANSACTION DETAILS
  // ============================================================

  Future<Map<String, dynamic>> getTransaction(int id) async {
    try {
      final Response response = await ApiClient.dio.get(
        "${ApiConstants.transactionDetails}/$id",
      );

      final data = Map<String, dynamic>.from(response.data);

      if (data["success"] != true) {
        throw Exception(data["message"] ?? "Unable to load transaction.");
      }

      final transaction = data["transaction"];

      if (transaction is! Map) {
        throw Exception("Transaction data is missing.");
      }

      return Map<String, dynamic>.from(transaction);
    } on DioException catch (e) {
      throw Exception(
        e.response?.data?["message"]?.toString() ??
            "Unable to load transaction.",
      );
    }
  }

  // ============================================================
  // SEND MONEY
  // ============================================================

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

  // ============================================================
  // FILTER TRANSACTIONS
  // ============================================================

  Future<List<Map<String, dynamic>>> filter({
    String? type,
    String? from,
    String? to,
  }) async {
    try {
      final Response response = await ApiClient.dio.get(
        "${ApiConstants.transactions}/filter",
        queryParameters: {
          if (type != null) "type": type,
          if (from != null) "from": from,
          if (to != null) "to": to,
        },
      );

      final data = Map<String, dynamic>.from(response.data);

      final transactions = data["transactions"];

      if (transactions is! List) {
        return [];
      }

      return transactions
          .whereType<Map>()
          .map((item) => Map<String, dynamic>.from(item))
          .toList();
    } on DioException catch (e) {
      throw Exception(
        e.response?.data?["message"]?.toString() ??
            "Unable to filter transactions.",
      );
    }
  }

  // ============================================================
  // RECEIPT
  // ============================================================

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
