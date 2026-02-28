import 'package:second_chat_bot/features/chat/data/models/chat_message_model.dart';

mixin ChatOutputValidator {
  static void validate(ChatMessageModel messages) {
    if (messages.parts.isEmpty) {
      throw ArgumentError(
        'API Response error: No content found in candidates.',
      );
    }

    for (final part in messages.parts) {
      if (part.text.trim().isEmpty) {
        throw ArgumentError(
          'API Response error: Empty text in response parts.',
        );
      }
    }
    if (messages.role.trim().isEmpty ||
        !['user', 'model', 'assistant'].contains(messages.role)) {
      throw ArgumentError('API Response error: Invalid role in response.');
    }
  }
}
