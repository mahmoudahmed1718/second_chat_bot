import 'package:dio/dio.dart';

class ApiInterceptor extends Interceptor {
  final String apiKey;

  ApiInterceptor({required this.apiKey});

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    options.headers.addAll({
      'x-goog-api-key': apiKey,
      'ContentType': 'application/json',
    });

    super.onRequest(options, handler);
  }
}
