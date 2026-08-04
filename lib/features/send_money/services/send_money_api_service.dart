import 'package:dio/dio.dart';

import '../../../core/api/api_client.dart';
import '../../../core/api/api_constants.dart';

class SendMoneyApiService {
  SendMoneyApiService._();

  static final SendMoneyApiService instance = SendMoneyApiService._();

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
    } catch (e) {
      throw Exception(e.toString().replaceFirst("Exception: ", ""));
    }
  }
}
