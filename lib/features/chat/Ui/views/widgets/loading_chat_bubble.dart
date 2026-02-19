import 'package:flutter/material.dart';
import 'package:second_chat_bot/features/chat/Ui/views/widgets/base_chat_bubble.dart';
import 'package:second_chat_bot/features/chat/Ui/views/widgets/loading_dots.dart';

class LoadingChatBubble extends StatelessWidget {
  const LoadingChatBubble({super.key});

  @override
  Widget build(BuildContext context) {
    return const BaseChatBubble(
      isUser: false,
      color: Color(0xFFF1F1F1),
      child: LoadingDots(),
    );
  }
}
