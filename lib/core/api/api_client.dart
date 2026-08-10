import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

import '../storage/token_storage.dart';
import 'api_constants.dart';

class ApiClient {
  ApiClient._();

  static final Dio dio =
      Dio(
          BaseOptions(
            baseUrl: ApiConstants.baseUrl,
            connectTimeout: const Duration(seconds: 30),
            receiveTimeout: const Duration(seconds: 30),
            sendTimeout: const Duration(seconds: 30),
            headers: {
              "Content-Type": "application/json",
              "Accept": "application/json",
            },
            responseType: ResponseType.json,
          ),
        )
        ..interceptors.add(
          InterceptorsWrapper(
            // =========================================================
            // REQUEST
            // =========================================================
            onRequest: (options, handler) async {
              final token = await TokenStorage.getToken();

              debugPrint("========== API REQUEST ==========");
              debugPrint("URL    : ${options.uri}");
              debugPrint("METHOD : ${options.method}");
              debugPrint(
                "TOKEN  : ${token == null || token.trim().isEmpty ? "NULL" : "FOUND"}",
              );

              if (token != null && token.trim().isNotEmpty) {
                options.headers["Authorization"] = "Bearer ${token.trim()}";
              }

              debugPrint("HEADERS: ${options.headers}");
              debugPrint("DATA   : ${options.data}");
              debugPrint("================================");

              handler.next(options);
            },

            // =========================================================
            // RESPONSE
            // =========================================================
            onResponse: (response, handler) {
              debugPrint("========== API RESPONSE ==========");
              debugPrint("STATUS : ${response.statusCode}");
              debugPrint("URL    : ${response.requestOptions.uri}");
              debugPrint("DATA   : ${response.data}");
              debugPrint("==================================");

              handler.next(response);
            },

            // =========================================================
            // ERROR
            // =========================================================
            onError: (DioException error, handler) {
              debugPrint("========== API ERROR ==========");
              debugPrint("TYPE     : ${error.type}");
              debugPrint("STATUS   : ${error.response?.statusCode}");
              debugPrint("URL      : ${error.requestOptions.uri}");
              debugPrint("MESSAGE  : ${error.message}");
              debugPrint("RESPONSE : ${error.response?.data}");
              debugPrint("HEADERS  : ${error.requestOptions.headers}");
              debugPrint("===============================");

              handler.next(error);
            },
          ),
        );
}
