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

              if (token != null && token.isNotEmpty) {
                options.headers["Authorization"] = "Bearer $token";
              } else {
                options.headers.remove("Authorization");
              }

              handler.next(options);
            },

            onError: (DioException error, handler) async {
              if (error.response?.statusCode == 401) {
                await TokenStorage.deleteToken();
              }

              handler.next(error);
            },
          ),
        );
}
