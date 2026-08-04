import 'package:dio/dio.dart';

import '../../../core/api/api_client.dart';
import '../../../core/api/api_constants.dart';

class SendMoneyApiService {
  SendMoneyApiService._();

  static final SendMoneyApiService instance = SendMoneyApiService._();

  Future<Map<String, dynamic>> sendMoney({
    required String receiverPhone,
    required double amount,
    String note = "",
  }) async {
    try {
      final Response response = await ApiClient.dio.post(
        ApiConstants.sendMoney,
        data: {"receiverPhone": receiverPhone, "amount": amount, "note": note},
      );

      return Map<String, dynamic>.from(response.data);
    } on DioException catch (e) {
      throw Exception(e.response?.data["message"] ?? "Money transfer failed.");
    }
  }
}
