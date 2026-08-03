import 'package:dio/dio.dart';

import '../../../core/api/api_client.dart';
import '../../../core/api/api_constants.dart';

class TransactionApiService {
  TransactionApiService._();

  static final TransactionApiService instance = TransactionApiService._();

  /*
  |--------------------------------------------------------------------------
  | Get All Transactions
  |--------------------------------------------------------------------------
  */

  Future<List<dynamic>> getTransactions() async {
    final Response response = await ApiClient.dio.get(
      ApiConstants.transactions,
    );

    return response.data["transactions"] ?? [];
  }

  /*
  |--------------------------------------------------------------------------
  | Get Transaction Details
  |--------------------------------------------------------------------------
  */

  Future<Map<String, dynamic>> getTransaction(int id) async {
    final Response response = await ApiClient.dio.get(
      "${ApiConstants.transactions}/$id",
    );

    return Map<String, dynamic>.from(response.data);
  }

  /*
  |--------------------------------------------------------------------------
  | Send Money
  |--------------------------------------------------------------------------
  */

  Future<Map<String, dynamic>> sendMoney({
    required int receiverId,
    required double amount,
    String? note,
  }) async {
    final Response response = await ApiClient.dio.post(
      "${ApiConstants.transactions}/send",
      data: {"receiver_id": receiverId, "amount": amount, "note": note},
    );

    return Map<String, dynamic>.from(response.data);
  }

  /*
  |--------------------------------------------------------------------------
  | Request Money
  |--------------------------------------------------------------------------
  */

  Future<Map<String, dynamic>> requestMoney({
    required int senderId,
    required double amount,
    String? note,
  }) async {
    final Response response = await ApiClient.dio.post(
      "${ApiConstants.transactions}/request",
      data: {"sender_id": senderId, "amount": amount, "note": note},
    );

    return Map<String, dynamic>.from(response.data);
  }

  /*
  |--------------------------------------------------------------------------
  | Filter Transactions
  |--------------------------------------------------------------------------
  */

  Future<List<dynamic>> filter({String? type, String? from, String? to}) async {
    final Response response = await ApiClient.dio.get(
      "${ApiConstants.transactions}/filter",
      queryParameters: {"type": type, "from": from, "to": to},
    );

    return response.data["transactions"] ?? [];
  }

  /*
  |--------------------------------------------------------------------------
  | Download Receipt
  |--------------------------------------------------------------------------
  */

  Future<String?> receipt(int transactionId) async {
    final Response response = await ApiClient.dio.get(
      "${ApiConstants.transactions}/$transactionId/receipt",
    );

    return response.data["url"];
  }
}
