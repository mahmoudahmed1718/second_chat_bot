import 'package:flutter/material.dart';
import 'package:second_chat_bot/features/chat/Ui/views/widgets/build_chat_bubble.dart';
import 'package:second_chat_bot/features/chat/domain/entites/gemini_message_entity.dart';

class MessagesListView extends StatelessWidget {
  const MessagesListView({
    super.key,
    required List<GeminiMessageEntity> messages,
  }) : _messages = messages;

  final List<GeminiMessageEntity> _messages;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: _messages.length,
      itemBuilder: (context, index) {
        final message = _messages[index];
        return ChatBubble(isUser: message.isFromUser, message: message.text);
      },
    );
  }
}
