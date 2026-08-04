import 'package:dio/dio.dart';

import '../../../core/api/api_client.dart';
import '../../../core/api/api_constants.dart';
import '../models/request_money_model.dart';

class RequestMoneyApiService {
  RequestMoneyApiService._();

  static final RequestMoneyApiService instance = RequestMoneyApiService._();

  /*
  |--------------------------------------------------------------------------
  | Request Money
  |--------------------------------------------------------------------------
  */

  Future<Map<String, dynamic>> requestMoney({
    required int receiverId,
    required double amount,
    String? note,
  }) async {
    try {
      final Response response = await ApiClient.dio.post(
        ApiConstants.requestMoney,
        data: {"receiver_id": receiverId, "amount": amount, "note": note},
      );

      return Map<String, dynamic>.from(response.data);
    } on DioException catch (e) {
      throw Exception(
        e.response?.data?["message"] ?? "Unable to request money.",
      );
    }
  }

  /*
  |--------------------------------------------------------------------------
  | Request History
  |--------------------------------------------------------------------------
  */

  Future<List<RequestMoneyModel>> getHistory() async {
    try {
      final Response response = await ApiClient.dio.get(
        ApiConstants.requestHistory,
      );

      final List<dynamic> data = response.data["requests"] ?? [];

      return data
          .map((e) => RequestMoneyModel.fromJson(Map<String, dynamic>.from(e)))
          .toList();
    } on DioException catch (e) {
      throw Exception(
        e.response?.data?["message"] ?? "Unable to load request history.",
      );
    }
  }

  /*
  |--------------------------------------------------------------------------
  | Request Details
  |--------------------------------------------------------------------------
  */

  Future<RequestMoneyModel> getRequestDetails(int id) async {
    try {
      final Response response = await ApiClient.dio.get(
        "${ApiConstants.requestMoney}/$id",
      );

      return RequestMoneyModel.fromJson(
        Map<String, dynamic>.from(response.data["request"]),
      );
    } on DioException catch (e) {
      throw Exception(
        e.response?.data?["message"] ?? "Unable to load request.",
      );
    }
  }

  /*
  |--------------------------------------------------------------------------
  | Accept Request
  |--------------------------------------------------------------------------
  */

  Future<void> acceptRequest(int id) async {
    try {
      await ApiClient.dio.post("${ApiConstants.requestMoney}/$id/accept");
    } on DioException catch (e) {
      throw Exception(
        e.response?.data?["message"] ?? "Unable to accept request.",
      );
    }
  }

  /*
  |--------------------------------------------------------------------------
  | Reject Request
  |--------------------------------------------------------------------------
  */

  Future<void> rejectRequest(int id) async {
    try {
      await ApiClient.dio.post("${ApiConstants.requestMoney}/$id/reject");
    } on DioException catch (e) {
      throw Exception(
        e.response?.data?["message"] ?? "Unable to reject request.",
      );
    }
  }

  /*
  |--------------------------------------------------------------------------
  | Delete Request
  |--------------------------------------------------------------------------
  */

  Future<void> deleteRequest(int id) async {
    try {
      await ApiClient.dio.delete("${ApiConstants.requestMoney}/$id");
    } on DioException catch (e) {
      throw Exception(
        e.response?.data?["message"] ?? "Unable to delete request.",
      );
    }
  }
}
