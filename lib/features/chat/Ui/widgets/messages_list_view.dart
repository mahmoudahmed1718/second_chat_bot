import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:second_chat_bot/features/chat/Ui/manger/cubit/chat_cubit.dart';
import 'package:second_chat_bot/features/chat/Ui/widgets/failed_chat_bubble.dart';

import 'package:second_chat_bot/features/chat/Ui/widgets/loading_chat_bubble.dart';
import 'package:second_chat_bot/features/chat/Ui/widgets/message_chat_bubble.dart';
import 'package:second_chat_bot/features/chat/domain/entites/gemini_message_entity.dart';

class MessagesListView extends StatelessWidget {
  const MessagesListView({super.key, required this.messages});

  final List<GeminiMessageEntity> messages;

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
          isUser: message.isFromUser,
          message: message.text,
        );
      },
    );
  }
}

class LoadingMessageListView extends StatelessWidget {
  const LoadingMessageListView({super.key, required this.messages});

  final List<GeminiMessageEntity> messages;

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
          isUser: message.isFromUser,
          message: message.text,
        );
      },
    );
  }
}

class FaileurMessagesListview extends StatelessWidget {
  const FaileurMessagesListview({super.key, required this.messages});
  final List<GeminiMessageEntity> messages;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      reverse: true,
      itemCount: messages.length + 1,
      itemBuilder: (context, index) {
        var newIndex = messages.length - (index + 0);

        if (index == 0) {
          return FailedBubble(
            message: messages[newIndex].text,
            onRetry: () {
              context.read<SendMessageCubit>().getGemineReponse(
                messages: messages,
              );
            },
          );
        }

        final message = messages[newIndex];

        return Visibility(
          visible: !(index == 1),
          child: MessageChatBubble(
            isUser: message.isFromUser,
            message: message.text,
          ),
        );
      },
    );
  }
}
