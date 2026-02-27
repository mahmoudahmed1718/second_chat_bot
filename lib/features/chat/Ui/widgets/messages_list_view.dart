import 'package:flutter/material.dart';
import 'package:second_chat_bot/features/chat/Ui/widgets/message_chat_bubble.dart';
import 'package:second_chat_bot/features/chat/data/models/chat_message_model.dart';

class MessagesListView extends StatelessWidget {
  const MessagesListView({super.key, required this.messages});

  final List<ChatMessageModel> messages;

  @override
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      reverse: true,
      itemCount: messages.length,
      itemBuilder: (context, index) {
        var reversedList = messages.reversed.toList();
        final message = reversedList[index];
        return MessageChatBubble(
          isUser: message.isUser,
          message: message.displayText.toString(),
        );
      },
    );
  }
}
