import 'package:dio/dio.dart';
import 'package:second_chat_bot/core/services/errors/error_model.dart';

class ServerException implements Exception {
  final ErrorModel errorModel;

  ServerException({required this.errorModel});
}

Future<void> handleErrorExpectation(
  DioException e, {
  int retryCount = 0,
}) async {
  final fallbackError = ErrorModel(
    statusCode: null,
    message: "No internet connection. Please check your network.",
    status: "NETWORK_ERROR",
  );

  switch (e.type) {
    case DioExceptionType.connectionTimeout:
    case DioExceptionType.sendTimeout:
    case DioExceptionType.receiveTimeout:
    case DioExceptionType.connectionError:
    case DioExceptionType.unknown:
      if (retryCount < 3) {
        // Retry up to 3 times for network errors
        await Future.delayed(Duration(seconds: 2));
        throw ServerException(errorModel: fallbackError);
      } else {
        throw ServerException(errorModel: fallbackError);
      }

    case DioExceptionType.badCertificate:
    case DioExceptionType.cancel:
      throw ServerException(
        errorModel: ErrorModel(
          statusCode: e.response?.statusCode,
          message: "Request cancelled or certificate issue.",
          status: e.response?.statusMessage,
        ),
      );

    case DioExceptionType.badResponse:
      if (e.response?.data != null) {
        throw ServerException(
          errorModel: ErrorModel.fromJson(e.response!.data),
        );
      } else {
        throw ServerException(errorModel: fallbackError);
      }
  }
}
