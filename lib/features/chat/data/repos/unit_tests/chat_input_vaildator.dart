// chat_input_validator.dart
import 'package:second_chat_bot/features/chat/data/models/chat_message_model.dart';

mixin ChatInputValidator {
  static void validateMessages(List<ChatMessageModel> messages) {
    if (messages.isEmpty) {
      throw ArgumentError("Messages list cannot be empty");
    }
    for (var msg in messages) {
      if (msg.displayText.trim().isEmpty) {
        throw ArgumentError("Messages list contains a message with empty text");
      }
    }
  }
}
