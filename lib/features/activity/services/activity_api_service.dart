import 'package:dio/dio.dart';

import '../../../core/api/api_client.dart';
import '../../../core/api/api_constants.dart';
import '../models/activity_model.dart';

class ActivityApiService {
  ActivityApiService._();

  static final ActivityApiService instance = ActivityApiService._();

  Future<List<ActivityModel>> getTransactions() async {
    try {
      final Response response = await ApiClient.dio.get(
        ApiConstants.transactions,
      );

      final data = response.data;

      if (data is Map &&
          data["transactions"] != null &&
          data["transactions"] is List) {
        return (data["transactions"] as List)
            .map((e) => ActivityModel.fromJson(Map<String, dynamic>.from(e)))
            .toList();
      }

      if (data is List) {
        return data
            .map((e) => ActivityModel.fromJson(Map<String, dynamic>.from(e)))
            .toList();
      }

      return [];
    } on DioException catch (e) {
      throw Exception(
        e.response?.data["message"] ?? "Unable to load transactions.",
      );
    } catch (e) {
      throw Exception("Unexpected Error: $e");
    }
  }
}
