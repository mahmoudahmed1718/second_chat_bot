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
      padding: const EdgeInsets.symmetric(vertical: 16),
      itemCount: messages.length + 1,
      itemBuilder: (context, index) {
        var newIndex = messages.length - (index + 0);

        if (index == 0) {
          return FailedBubble(
            message: 'error',
            onRetry: () {
              context.read<SendMessageCubit>().sendMessage(messages: messages);
            },
          );
        }
        final msg = messages[newIndex];
        return Visibility(
          visible: hideIFErrorMessage(index),
          child: MessageChatBubble(
            isUser: msg.isUser,
            message: msg.displayText.toString(),
          ),
        );
      },
    );
  }

  /// Returns true if the message at [index] should be visible.
  ///
  /// When an error (failure) occurs, the error bubble is inserted at index 0,
  /// and the most recent (last) user message is at index 1. To prevent showing
  /// the last user message twice (once in the error bubble, once as a normal bubble),
  /// this function hides the message at index 1 when isFailure is true.
  ///
  /// In all other cases (not failure, or any other index), the message is visible.
  bool hideIFErrorMessage(int index) {
    return index != 1;
  }
}
