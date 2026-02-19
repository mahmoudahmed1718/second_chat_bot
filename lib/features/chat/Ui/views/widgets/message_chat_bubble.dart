import 'package:flutter/material.dart';
import 'package:second_chat_bot/features/chat/Ui/views/widgets/base_chat_bubble.dart';

class MessageChatBubble extends StatelessWidget {
  final bool isUser;
  final String message;

  const MessageChatBubble({
    super.key,
    required this.isUser,
    required this.message,
  });

  @override
  Widget build(BuildContext context) {
    return BaseChatBubble(
      isUser: isUser,
      color: isUser ? const Color(0xFF2F66F6) : const Color(0xFFF1F1F1),
      child: Text(
        message,
        style: TextStyle(
          color: isUser ? Colors.white : Colors.black87,
          fontSize: 14,
          height: 1.4,
        ),
      ),
    );
  }
}
