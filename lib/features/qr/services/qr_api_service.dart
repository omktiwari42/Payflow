import 'package:dio/dio.dart';

import '../../../core/api/api_client.dart';
import '../../../core/api/api_constants.dart';

class QrApiService {
  QrApiService._();

  static final QrApiService instance = QrApiService._();

  /*
  |--------------------------------------------------------------------------
  | Generate My QR
  |--------------------------------------------------------------------------
  */

  Future<Map<String, dynamic>> generateQr() async {
    final Response response = await ApiClient.dio.get(
      "${ApiConstants.qr}/generate",
    );

    return Map<String, dynamic>.from(response.data);
  }

  /*
  |--------------------------------------------------------------------------
  | Scan QR
  |--------------------------------------------------------------------------
  */

  Future<Map<String, dynamic>> scanQr({String? phone, String? upiId}) async {
    final Response response = await ApiClient.dio.post(
      "${ApiConstants.qr}/scan",
      data: {"phone": phone, "upi_id": upiId},
    );

    return Map<String, dynamic>.from(response.data);
  }

  /*
  |--------------------------------------------------------------------------
  | Pay Through QR
  |--------------------------------------------------------------------------
  */

  Future<Map<String, dynamic>> payQr({
    required int receiverId,
    required double amount,
  }) async {
    final Response response = await ApiClient.dio.post(
      "${ApiConstants.qr}/pay",
      data: {"receiver_id": receiverId, "amount": amount},
    );

    return Map<String, dynamic>.from(response.data);
  }

  /*
  |--------------------------------------------------------------------------
  | QR Payment History
  |--------------------------------------------------------------------------
  */

  Future<List<dynamic>> paymentHistory() async {
    final Response response = await ApiClient.dio.get(
      ApiConstants.transactions,
      queryParameters: {"type": "QR Payment"},
    );

    return response.data["transactions"] ?? [];
  }
}
