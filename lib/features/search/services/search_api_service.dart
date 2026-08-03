import 'package:dio/dio.dart';

import '../../../core/api/api_client.dart';
import '../../../core/api/api_constants.dart';

class SearchApiService {
  SearchApiService._();

  static final SearchApiService instance = SearchApiService._();

  /*
  |--------------------------------------------------------------------------
  | Global Search
  |--------------------------------------------------------------------------
  */

  Future<Map<String, dynamic>> search(String keyword) async {
    final Response response = await ApiClient.dio.get(
      ApiConstants.search,
      queryParameters: {"q": keyword},
    );

    return Map<String, dynamic>.from(response.data);
  }

  /*
  |--------------------------------------------------------------------------
  | Search Users
  |--------------------------------------------------------------------------
  */

  Future<List<dynamic>> users(String keyword) async {
    final data = await search(keyword);

    return data["results"]["users"] ?? [];
  }

  /*
  |--------------------------------------------------------------------------
  | Search Contacts
  |--------------------------------------------------------------------------
  */

  Future<List<dynamic>> contacts(String keyword) async {
    final data = await search(keyword);

    return data["results"]["contacts"] ?? [];
  }

  /*
  |--------------------------------------------------------------------------
  | Search Beneficiaries
  |--------------------------------------------------------------------------
  */

  Future<List<dynamic>> beneficiaries(String keyword) async {
    final data = await search(keyword);

    return data["results"]["beneficiaries"] ?? [];
  }

  /*
  |--------------------------------------------------------------------------
  | Search Bills
  |--------------------------------------------------------------------------
  */

  Future<List<dynamic>> bills(String keyword) async {
    final data = await search(keyword);

    return data["results"]["bills"] ?? [];
  }

  /*
  |--------------------------------------------------------------------------
  | Search Transactions
  |--------------------------------------------------------------------------
  */

  Future<List<dynamic>> transactions(String keyword) async {
    final data = await search(keyword);

    return data["results"]["transactions"] ?? [];
  }
}
