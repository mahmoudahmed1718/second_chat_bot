import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:second_chat_bot/features/chat/Ui/manger/cubit/chat_cubit.dart';
import 'package:second_chat_bot/features/chat/Ui/widgets/failed_chat_bubble.dart';
import 'package:second_chat_bot/features/chat/Ui/widgets/message_chat_bubble.dart';
import 'package:second_chat_bot/features/chat/data/models/chat_message_model.dart';

class FaileurMessagesListview extends StatelessWidget {
  const FaileurMessagesListview({super.key, required this.messages});
  final List<ChatMessageModel> messages;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      reverse: true,
      itemCount: messages.length + 1,
      itemBuilder: (context, index) {
        var newIndex = messages.length - (index + 1);

        if (index == 0) {
          return FailedBubble(
            message: messages[newIndex].displayText,
            onRetry: () {
              context.read<SendMessageCubit>().sendMessage(messages: messages);
            },
          );
        }

        final message = messages[newIndex];

        return Visibility(
          visible: !(index == 1),
          child: MessageChatBubble(
            isUser: message.isUser,
            message: message.displayText,
          ),
        );
      },
    );
  }
}
