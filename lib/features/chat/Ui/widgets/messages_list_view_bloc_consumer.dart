import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:second_chat_bot/features/chat/Ui/manger/cubit/chat_cubit.dart';
import 'package:second_chat_bot/features/chat/Ui/widgets/build_suggetion_widget.dart';
import 'package:second_chat_bot/features/chat/Ui/widgets/faileur_messaage_list_view.dart';
import 'package:second_chat_bot/features/chat/Ui/widgets/loading_messages_list_view.dart';
import 'package:second_chat_bot/features/chat/Ui/widgets/messages_list_view.dart';
import 'package:second_chat_bot/features/chat/data/models/chat_message_model.dart';

class MessageListViewBlocConsumer extends StatelessWidget {
  const MessageListViewBlocConsumer({
    super.key,
    required List<ChatMessageModel> messages,
  }) : _messages = messages;

  final List<ChatMessageModel> _messages;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SendMessageCubit, SendMessageState>(
      listener: (context, state) {
        if (state is SendMessageSuccess) {
          _messages.add(state.chatMessageModel);
        }
      },
      builder: (context, state) {
        if (state is SendMessageInitial) {
          return SuggestionWidget(messages: _messages);
        } else if (state is SendMessageSuccess) {
          return MessagesListView(messages: _messages);
        } else if (state is SendMessageFailure) {
          return FaileurMessagesListview(messages: _messages);
        } else if (state is SendMessageLoading) {
          return LoadingMessageListView(messages: _messages);
        }
        return SizedBox.shrink();
      },
    );
  }
}
