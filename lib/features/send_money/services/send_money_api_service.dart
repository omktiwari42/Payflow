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
        data: {"phone": phone.trim(), "amount": amount, "note": note.trim()},
      );

      final Map<String, dynamic> data = Map<String, dynamic>.from(
        response.data,
      );

      if (response.statusCode != 200 || data["success"] != true) {
        throw Exception(
          data["message"]?.toString() ?? "Money transfer failed.",
        );
      }

      return data;
    } on DioException catch (e) {
      if (e.response?.data is Map) {
        throw Exception(
          e.response?.data["message"]?.toString() ?? "Money transfer failed.",
        );
      }

      throw Exception(e.message ?? "Unable to connect to server.");
    } catch (e) {
      throw Exception(e.toString().replaceFirst("Exception: ", ""));
    }
  }
}
