import 'package:dio/dio.dart';

import '../../../core/api/api_client.dart';
import '../../../core/api/api_constants.dart';
import '../models/bank_account_model.dart';

class BankAccountApiService {
  BankAccountApiService._();

  static final BankAccountApiService instance = BankAccountApiService._();

  /*
  |--------------------------------------------------------------------------
  | Get Bank Accounts
  |--------------------------------------------------------------------------
  */

  Future<List<BankAccountModel>> getBankAccounts() async {
    try {
      final Response response = await ApiClient.dio.get(
        ApiConstants.bankAccounts,
      );

      final data = Map<String, dynamic>.from(response.data);

      if (data["success"] != true) {
        throw Exception(data["message"] ?? "Unable to fetch bank accounts.");
      }

      return (data["accounts"] as List<dynamic>? ?? [])
          .map((e) => BankAccountModel.fromJson(Map<String, dynamic>.from(e)))
          .toList();
    } on DioException catch (e) {
      throw Exception(
        e.response?.data?["message"]?.toString() ??
            "Unable to fetch bank accounts.",
      );
    }
  }

  /*
  |--------------------------------------------------------------------------
  | Add Bank Account
  |--------------------------------------------------------------------------
  */

  Future<void> addBankAccount({
    required String bankName,
    required String accountHolderName,
    required String accountNumber,
    required String ifscCode,
  }) async {
    try {
      final Response response = await ApiClient.dio.post(
        ApiConstants.bankAccounts,
        data: {
          "bank_name": bankName,
          "account_holder": accountHolderName,
          "account_number": accountNumber,
          "ifsc": ifscCode,
        },
      );

      final data = Map<String, dynamic>.from(response.data);

      if (data["success"] != true) {
        throw Exception(data["message"] ?? "Unable to add bank account.");
      }
    } on DioException catch (e) {
      throw Exception(
        e.response?.data?["message"]?.toString() ??
            "Unable to add bank account.",
      );
    }
  }

  /*
  |--------------------------------------------------------------------------
  | Delete Bank Account
  |--------------------------------------------------------------------------
  */

  Future<void> deleteBankAccount(int id) async {
    try {
      final Response response = await ApiClient.dio.delete(
        "${ApiConstants.bankAccounts}/$id",
      );

      final data = Map<String, dynamic>.from(response.data);

      if (data["success"] != true) {
        throw Exception(data["message"] ?? "Unable to delete bank account.");
      }
    } on DioException catch (e) {
      throw Exception(
        e.response?.data?["message"]?.toString() ??
            "Unable to delete bank account.",
      );
    }
  }

  /*
  |--------------------------------------------------------------------------
  | Set Primary Bank Account
  |--------------------------------------------------------------------------
  */

  Future<void> setPrimary(int id) async {
    try {
      final Response response = await ApiClient.dio.patch(
        "${ApiConstants.bankAccounts}/$id/primary",
      );

      final data = Map<String, dynamic>.from(response.data);

      if (data["success"] != true) {
        throw Exception(data["message"] ?? "Unable to update primary account.");
      }
    } on DioException catch (e) {
      throw Exception(
        e.response?.data?["message"]?.toString() ??
            "Unable to update primary account.",
      );
    }
  }
}
