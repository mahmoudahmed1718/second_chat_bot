import 'package:second_chat_bot/features/chat/data/models/chat_message_model.dart';

class ChatOutputValidator {
  static void validate(ChatMessageModel messages) {
    // Check if parts exist
    if (messages.parts.isEmpty) {
      throw StateError('API Response error: No content found in candidates.');
    }

    for (final part in messages.parts) {
      if (part.text.trim().isEmpty) {
        throw StateError('API Response error: Empty text in response parts.');
      }
    }
    if (messages.role.trim().isEmpty ||
        !['user', 'model', 'assistant'].contains(messages.role)) {
      throw StateError('API Response error: Invalid role in response.');
    }
  }
}
