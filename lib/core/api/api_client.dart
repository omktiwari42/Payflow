import 'package:dio/dio.dart';

import '../storage/token_storage.dart';
import 'api_constants.dart';

class ApiClient {
  ApiClient._();

  static final Dio dio =
      Dio(
          BaseOptions(
            baseUrl: ApiConstants.baseUrl,
            connectTimeout: const Duration(seconds: 20),
            receiveTimeout: const Duration(seconds: 20),
            sendTimeout: const Duration(seconds: 20),
            headers: {"Content-Type": "application/json"},
          ),
        )
        ..interceptors.add(
          InterceptorsWrapper(
            onRequest: (options, handler) async {
              final token = await TokenStorage.getToken();

              if (token != null) {
                options.headers["Authorization"] = "Bearer $token";
              }

              handler.next(options);
            },

            onError: (error, handler) {
              handler.next(error);
            },
          ),
        );
}
