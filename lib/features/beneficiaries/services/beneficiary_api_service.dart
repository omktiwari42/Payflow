import 'package:dio/dio.dart';

import '../../../core/api/api_client.dart';
import '../../../core/api/api_constants.dart';
import '../models/beneficiary_model.dart';

class BeneficiaryApiService {
  BeneficiaryApiService._();

  static final BeneficiaryApiService instance = BeneficiaryApiService._();

  /*
  |--------------------------------------------------------------------------
  | Get Beneficiaries
  |--------------------------------------------------------------------------
  */

  Future<List<BeneficiaryModel>> getBeneficiaries() async {
    try {
      final Response response = await ApiClient.dio.get(
        ApiConstants.beneficiaries,
      );

      final data = Map<String, dynamic>.from(response.data);

      if (data["success"] != true) {
        throw Exception(data["message"] ?? "Unable to load beneficiaries.");
      }

      return (data["beneficiaries"] as List<dynamic>? ?? [])
          .map((e) => BeneficiaryModel.fromJson(Map<String, dynamic>.from(e)))
          .toList();
    } on DioException catch (e) {
      throw Exception(
        e.response?.data?["message"]?.toString() ??
            "Unable to load beneficiaries.",
      );
    }
  }

  /*
  |--------------------------------------------------------------------------
  | Add Beneficiary
  |--------------------------------------------------------------------------
  */

  Future<void> addBeneficiary({
    required String fullName,
    required String phone,
    String? upiId,
  }) async {
    try {
      final Response response = await ApiClient.dio.post(
        ApiConstants.beneficiaries,
        data: {"full_name": fullName, "phone": phone, "upi_id": upiId},
      );

      final data = Map<String, dynamic>.from(response.data);

      if (data["success"] != true) {
        throw Exception(data["message"] ?? "Unable to add beneficiary.");
      }
    } on DioException catch (e) {
      throw Exception(
        e.response?.data?["message"]?.toString() ??
            "Unable to add beneficiary.",
      );
    }
  }

  /*
  |--------------------------------------------------------------------------
  | Delete Beneficiary
  |--------------------------------------------------------------------------
  */

  Future<void> deleteBeneficiary(int id) async {
    try {
      final Response response = await ApiClient.dio.delete(
        "${ApiConstants.beneficiaries}/$id",
      );

      final data = Map<String, dynamic>.from(response.data);

      if (data["success"] != true) {
        throw Exception(data["message"] ?? "Unable to delete beneficiary.");
      }
    } on DioException catch (e) {
      throw Exception(
        e.response?.data?["message"]?.toString() ??
            "Unable to delete beneficiary.",
      );
    }
  }

  /*
  |--------------------------------------------------------------------------
  | Search Beneficiaries
  |--------------------------------------------------------------------------
  */

  Future<List<BeneficiaryModel>> search(String query) async {
    try {
      final Response response = await ApiClient.dio.get(
        ApiConstants.beneficiaries,
        queryParameters: {"search": query},
      );

      final data = Map<String, dynamic>.from(response.data);

      if (data["success"] != true) {
        throw Exception(data["message"] ?? "Search failed.");
      }

      return (data["beneficiaries"] as List<dynamic>? ?? [])
          .map((e) => BeneficiaryModel.fromJson(Map<String, dynamic>.from(e)))
          .toList();
    } on DioException catch (e) {
      throw Exception(
        e.response?.data?["message"]?.toString() ?? "Search failed.",
      );
    }
  }
}
