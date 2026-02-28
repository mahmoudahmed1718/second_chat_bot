import 'package:dio/dio.dart';
import 'package:second_chat_bot/core/services/api/api_client.dart';
import 'package:second_chat_bot/features/chat/data/models/chat_message_model.dart';

class GemenaiChatService {
  final DioApiClient apiClient;

  static const int maxAttempts = 3;

  GemenaiChatService({required this.apiClient});

  Future<ChatMessageModel> sendMessage({
    required List<ChatMessageModel> messages,
  }) async {
    int attempts = 0;

    while (attempts < maxAttempts) {
      try {
        print('Attempt: ${attempts + 1}');
        attempts++;

        final response = await apiClient.post(
          '/gemini-3-flash-preview:generateContent',
          data: {
            "contents": messages.map((message) => message.toJson()).toList(),
          },
          options: Options(
            headers: {
              "Content-Type": "application/json",
              "x-goog-api-key": "AIzaSyBR7gvONerBniwOVPCt3pvmHwW4mP40fck",
            },
          ),
        );

        return ChatMessageModel.fromJson(response['candidates'][0]['content']);
      } catch (e) {
        if (!_shouldRetry(e) || attempts == maxAttempts) rethrow;

        await Future.delayed(Duration(seconds: 1));
      }
    }
    throw Exception("Failed after retries");
  }

  static const _retryTypes = {
    DioExceptionType.connectionError,
    DioExceptionType.connectionTimeout,
    DioExceptionType.sendTimeout,
    DioExceptionType.receiveTimeout,
  };
  bool _shouldRetry(Object e) {
    if (e is DioException) {
      return _retryTypes.contains(e.type);
    }
    return false;
  }
}
