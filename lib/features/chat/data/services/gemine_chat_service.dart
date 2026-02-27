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
      } on DioException catch (e) {
        if (e.response != null) {
          throw Exception("Server error");
        }

        if (e.type == DioExceptionType.connectionError ||
            e.type == DioExceptionType.connectionTimeout) {
          if (attempts >= maxAttempts) {
            throw Exception("No internet connection");
          }
        } else {
          throw Exception("Unexpected error");
        }
      }
    }

    throw Exception("Failed after retries");
  }
}
