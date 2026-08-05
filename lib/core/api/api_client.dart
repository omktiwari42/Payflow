import 'package:dio/dio.dart';

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
            onRequest: (options, handler) async {
              final token = await TokenStorage.getToken();

              print("========== TOKEN ==========");
              print(token ?? "NULL");
              print("===========================");

              if (token != null && token.isNotEmpty) {
                options.headers["Authorization"] = "Bearer $token";
              }

              print("========== REQUEST ==========");
              print("URL      : ${options.uri}");
              print("Method   : ${options.method}");
              print("Headers  : ${options.headers}");
              print("Data     : ${options.data}");
              print("=============================");

              handler.next(options);
            },

            onResponse: (response, handler) {
              print("========== RESPONSE ==========");
              print("Status   : ${response.statusCode}");
              print("URL      : ${response.requestOptions.uri}");
              print("Data     : ${response.data}");
              print("==============================");

              handler.next(response);
            },

            onError: (DioException error, handler) {
              print("========== DIO ERROR ==========");
              print("Type     : ${error.type}");
              print("Message  : ${error.message}");
              print("URL      : ${error.requestOptions.uri}");
              print("Headers  : ${error.requestOptions.headers}");
              print("Status   : ${error.response?.statusCode}");
              print("Response : ${error.response?.data}");
              print("Error    : ${error.error}");
              print("===============================");

              handler.next(error);
            },
          ),
        );
}
