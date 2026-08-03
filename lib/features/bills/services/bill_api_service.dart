import 'package:dio/dio.dart';

import '../../../core/api/api_client.dart';
import '../../../core/api/api_constants.dart';

class BillApiService {
  BillApiService._();

  static final BillApiService instance = BillApiService._();

  /*
  |--------------------------------------------------------------------------
  | Get All Bills
  |--------------------------------------------------------------------------
  */

  Future<List<dynamic>> getBills() async {
    final Response response = await ApiClient.dio.get(ApiConstants.bills);

    return response.data["bills"] ?? [];
  }

  /*
  |--------------------------------------------------------------------------
  | Add Bill
  |--------------------------------------------------------------------------
  */

  Future<Map<String, dynamic>> addBill({
    required String title,
    required String category,
    required String accountNumber,
    required double amount,
    required String dueDate,
  }) async {
    final Response response = await ApiClient.dio.post(
      ApiConstants.bills,
      data: {
        "title": title,
        "category": category,
        "account_number": accountNumber,
        "amount": amount,
        "due_date": dueDate,
      },
    );

    return Map<String, dynamic>.from(response.data);
  }

  /*
  |--------------------------------------------------------------------------
  | Pay Bill
  |--------------------------------------------------------------------------
  */

  Future<Map<String, dynamic>> payBill(int billId) async {
    final Response response = await ApiClient.dio.put(
      "${ApiConstants.bills}/$billId/pay",
    );

    return Map<String, dynamic>.from(response.data);
  }

  /*
  |--------------------------------------------------------------------------
  | Delete Bill
  |--------------------------------------------------------------------------
  */

  Future<Map<String, dynamic>> deleteBill(int billId) async {
    final Response response = await ApiClient.dio.delete(
      "${ApiConstants.bills}/$billId",
    );

    return Map<String, dynamic>.from(response.data);
  }

  /*
  |--------------------------------------------------------------------------
  | Upcoming Bills
  |--------------------------------------------------------------------------
  */

  Future<List<dynamic>> getUpcomingBills() async {
    final Response response = await ApiClient.dio.get(
      "${ApiConstants.bills}/upcoming",
    );

    return response.data["bills"] ?? [];
  }

  /*
  |--------------------------------------------------------------------------
  | Bill History
  |--------------------------------------------------------------------------
  */

  Future<List<dynamic>> getBillHistory() async {
    final Response response = await ApiClient.dio.get(
      "${ApiConstants.bills}/history",
    );

    return response.data["bills"] ?? [];
  }
}
