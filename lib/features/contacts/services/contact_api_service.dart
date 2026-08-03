import 'package:dio/dio.dart';

import '../../../core/api/api_client.dart';
import '../../../core/api/api_constants.dart';

class ContactApiService {
  ContactApiService._();

  static final ContactApiService instance = ContactApiService._();

  /*
  |--------------------------------------------------------------------------
  | Get Contacts
  |--------------------------------------------------------------------------
  */

  Future<List<dynamic>> getContacts() async {
    final Response response = await ApiClient.dio.get(ApiConstants.contacts);

    return response.data["contacts"] ?? [];
  }

  /*
  |--------------------------------------------------------------------------
  | Get Contact
  |--------------------------------------------------------------------------
  */

  Future<Map<String, dynamic>> getContact(int id) async {
    final Response response = await ApiClient.dio.get(
      "${ApiConstants.contacts}/$id",
    );

    return Map<String, dynamic>.from(response.data);
  }

  /*
  |--------------------------------------------------------------------------
  | Add Contact
  |--------------------------------------------------------------------------
  */

  Future<Map<String, dynamic>> addContact({
    required String fullName,
    required String phone,
    String? email,
    String? upiId,
  }) async {
    final Response response = await ApiClient.dio.post(
      ApiConstants.contacts,
      data: {
        "full_name": fullName,
        "phone": phone,
        "email": email,
        "upi_id": upiId,
      },
    );

    return Map<String, dynamic>.from(response.data);
  }

  /*
  |--------------------------------------------------------------------------
  | Update Contact
  |--------------------------------------------------------------------------
  */

  Future<Map<String, dynamic>> updateContact({
    required int id,
    required String fullName,
    required String phone,
    String? email,
    String? upiId,
  }) async {
    final Response response = await ApiClient.dio.put(
      "${ApiConstants.contacts}/$id",
      data: {
        "full_name": fullName,
        "phone": phone,
        "email": email,
        "upi_id": upiId,
      },
    );

    return Map<String, dynamic>.from(response.data);
  }

  /*
  |--------------------------------------------------------------------------
  | Delete Contact
  |--------------------------------------------------------------------------
  */

  Future<Map<String, dynamic>> deleteContact(int id) async {
    final Response response = await ApiClient.dio.delete(
      "${ApiConstants.contacts}/$id",
    );

    return Map<String, dynamic>.from(response.data);
  }

  /*
  |--------------------------------------------------------------------------
  | Search Contacts
  |--------------------------------------------------------------------------
  */

  Future<List<dynamic>> search(String query) async {
    final Response response = await ApiClient.dio.get(
      ApiConstants.contacts,
      queryParameters: {"search": query},
    );

    return response.data["contacts"] ?? [];
  }
}
