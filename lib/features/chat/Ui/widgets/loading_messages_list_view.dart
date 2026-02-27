import 'package:flutter/material.dart';
import 'package:second_chat_bot/features/chat/Ui/widgets/loading_chat_bubble.dart';
import 'package:second_chat_bot/features/chat/Ui/widgets/message_chat_bubble.dart';
import 'package:second_chat_bot/features/chat/data/models/chat_message_model.dart';

class LoadingMessageListView extends StatelessWidget {
  const LoadingMessageListView({super.key, required this.messages});

  final List<ChatMessageModel> messages;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      reverse: true,
      itemCount: messages.length + 1,
      itemBuilder: (context, index) {
        var newIndex = messages.length - (index + 0);
        if (index == 0) {
          return const LoadingChatBubble();
        }

        final message = messages[newIndex];

        return MessageChatBubble(
          isUser: message.isUser,
          message: message.displayText,
        );
      },
    );
  }
}
