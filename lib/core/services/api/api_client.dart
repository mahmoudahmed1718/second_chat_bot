import 'package:dio/dio.dart';

class DioApiClient {
  DioApiClient({
    required String baseUrl,
    Duration? connectTimeout,
    Duration? receiveTimeout,
    Duration? sendTimeout,
    Map<String, dynamic>? headers,
    List<Interceptor>? interceptors,
  }) : _dio = Dio(
         BaseOptions(
           baseUrl: baseUrl,
           connectTimeout: connectTimeout ?? const Duration(seconds: 30),
           receiveTimeout: receiveTimeout ?? const Duration(seconds: 30),
           sendTimeout: sendTimeout ?? const Duration(seconds: 30),
           headers: headers ?? _defaultHeaders,
         ),
       ) {
    _dio.interceptors.addAll([
      LogInterceptor(requestBody: true, responseBody: true, error: true),
      ...?interceptors,
    ]);
  }

  static const Map<String, dynamic> _defaultHeaders = {
    'Accept': 'application/json',
    'Content-Type': 'application/json',
  };

  final Dio _dio;

  /// Adds an interceptor (e.g. auth token). Implementation-specific.
  void addInterceptor(Interceptor interceptor) {
    _dio.interceptors.add(interceptor);
  }

  /// GET [path]. Returns decoded response body. Throws on error.
  Future<T> get<T>(
    String path, {
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
  }) async {
    final response = await _dio.get<T>(
      path,
      queryParameters: queryParameters,
      options: options,
      cancelToken: cancelToken,
    );
    return response.data as T;
  }

  /// POST [path]. Returns decoded response body. Throws on error.
  Future<T> post<T>(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
  }) async {
    final response = await _dio.post<T>(
      path,
      data: data,
      queryParameters: queryParameters,
      options: options,
      cancelToken: cancelToken,
    );
    return response.data as T;
  }

  /// PUT [path]. Returns decoded response body. Throws on error.
  Future<T> put<T>(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
  }) async {
    final response = await _dio.put<T>(
      path,
      data: data,
      queryParameters: queryParameters,
      options: options,
      cancelToken: cancelToken,
    );
    return response.data as T;
  }

  /// PATCH [path]. Returns decoded response body. Throws on error.
  Future<T> patch<T>(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
  }) async {
    final response = await _dio.patch<T>(
      path,
      data: data,
      queryParameters: queryParameters,
      options: options,
      cancelToken: cancelToken,
    );
    return response.data as T;
  }

  /// DELETE [path]. Returns decoded response body. Throws on error.
  Future<T> delete<T>(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
  }) async {
    final response = await _dio.delete<T>(
      path,
      data: data,
      queryParameters: queryParameters,
      options: options,
      cancelToken: cancelToken,
    );
    return response.data as T;
  }
}
