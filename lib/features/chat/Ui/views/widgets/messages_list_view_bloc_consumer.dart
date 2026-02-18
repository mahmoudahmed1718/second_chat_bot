import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:second_chat_bot/features/chat/Ui/manger/cubit/chat_cubit.dart';
import 'package:second_chat_bot/features/chat/Ui/views/widgets/messages_list_view.dart';
import 'package:second_chat_bot/features/chat/domain/entites/gemini_message_entity.dart';

class MessageListViewBlocConsumer extends StatelessWidget {
  const MessageListViewBlocConsumer({
    super.key,
    required List<GeminiMessageEntity> messages,
  }) : _messages = messages;

  final List<GeminiMessageEntity> _messages;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SendMessageCubit, SendMessageState>(
      listener: (context, state) {
        if (state is SendMessageLoaded) {
          _messages.add(state.message);
        }
      },
      builder: (context, state) {
        return MessagesListView(messages: _messages);
      },
    );
  }
}
