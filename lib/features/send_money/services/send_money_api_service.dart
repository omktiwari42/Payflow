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
    final normalizedPhone = _normalizePhone(phone);

    if (normalizedPhone.isEmpty) {
      throw Exception("Invalid recipient phone number.");
    }

    if (!amount.isFinite || amount <= 0) {
      throw Exception("Invalid payment amount.");
    }

    try {
      final response = await ApiClient.dio.post(
        ApiConstants.sendMoney,
        data: {"phone": normalizedPhone, "amount": amount, "note": note.trim()},
      );

      final data = Map<String, dynamic>.from(response.data);

      if (data["success"] != true) {
        throw Exception(
          data["message"]?.toString() ?? "Money transfer failed.",
        );
      }

      return data;
    } on DioException catch (e) {
      final responseData = e.response?.data;

      if (responseData is Map) {
        final message = responseData["message"]?.toString();

        if (message != null && message.isNotEmpty) {
          throw Exception(message);
        }
      }

      if (e.type == DioExceptionType.connectionError) {
        throw Exception("Unable to connect to PayFlow server.");
      }

      throw Exception(e.message ?? "Money transfer failed.");
    }
  }

  // ============================================================
  // PHONE NORMALIZATION
  // ============================================================

  String _normalizePhone(String value) {
    var digits = value.replaceAll(RegExp(r"\D"), "");

    if (digits.length == 12 && digits.startsWith("91")) {
      digits = digits.substring(2);
    }

    if (digits.length == 11 && digits.startsWith("0")) {
      digits = digits.substring(1);
    }

    if (digits.length != 10) {
      return "";
    }

    final first = digits.substring(0, 1);

    if (!RegExp(r"[6-9]").hasMatch(first)) {
      return "";
    }

    return digits;
  }
}
