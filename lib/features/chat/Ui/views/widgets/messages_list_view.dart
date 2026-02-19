import 'package:flutter/material.dart';

import 'package:second_chat_bot/features/chat/Ui/views/widgets/loading_chat_bubble.dart';
import 'package:second_chat_bot/features/chat/Ui/views/widgets/message_chat_bubble.dart';
import 'package:second_chat_bot/features/chat/domain/entites/gemini_message_entity.dart';

class MessagesListView extends StatelessWidget {
  const MessagesListView({
    super.key,
    required this.messages,
    required this.isloading,
  });

  final List<GeminiMessageEntity> messages;
  final bool isloading;

  @override
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      reverse: true,
      itemCount: isloading ? messages.length + 1 : messages.length,
      itemBuilder: (context, index) {
        var newIndex = messages.length - (index + (isloading ? 0 : 1));
        if (isloading && index == 0) {
          return const LoadingChatBubble();
        }

        final message = messages[newIndex];

        return MessageChatBubble(
          isUser: message.isFromUser,
          message: message.text,
        );
      },
    );
  }
}
