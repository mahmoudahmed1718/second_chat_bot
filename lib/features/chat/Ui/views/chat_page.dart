import 'package:flutter/material.dart';
import 'package:second_chat_bot/features/chat/Ui/views/widgets/build_chat_app_bar.dart';

import 'package:second_chat_bot/features/chat/Ui/views/widgets/messages_list_view.dart';
import 'package:second_chat_bot/features/chat/domain/entites/gemini_message_entity.dart';

class ChatView extends StatefulWidget {
  const ChatView({super.key});
  static const routeName = '/home';

  @override
  State<ChatView> createState() => _ChatViewState();
}

class _ChatViewState extends State<ChatView> {
  final List<GeminiMessageEntity> _messages = [];

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: buildChatAppBar(context),
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Expanded(child: MessagesListView(messages: _messages)),
          // BuildInputText(onSend: )
        ],
      ),
    );
  }
}
