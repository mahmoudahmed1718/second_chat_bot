import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:second_chat_bot/features/chat/Ui/manger/cubit/chat_cubit.dart';
import 'package:second_chat_bot/features/chat/Ui/widgets/build_suggetion_widget.dart';
import 'package:second_chat_bot/features/chat/Ui/widgets/faileur_messaage_list_view.dart';
import 'package:second_chat_bot/features/chat/Ui/widgets/loading_messages_list_view.dart';
import 'package:second_chat_bot/features/chat/Ui/widgets/messages_list_view.dart';
import 'package:second_chat_bot/features/chat/domain/entites/chat_entity.dart';

class MessageListViewBlocConsumer extends StatelessWidget {
  const MessageListViewBlocConsumer({
    super.key,
    required List<ChatEntity> messages,
  }) : _messages = messages;

  final List<ChatEntity> _messages;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SendMessageCubit, SendMessageState>(
      listener: (context, state) {
        if (state is SendMessageLoaded) {
          _messages.add(state.message);
        }
      },
      builder: (context, state) {
        if (state is SendMessageInitial) {
          return SuggestionWidget(messages: _messages);
        } else if (state is SendMessageLoaded) {
          return MessagesListView(messages: _messages);
        } else if (state is SendMessageError) {
          return FaileurMessagesListview(messages: _messages);
        } else if (state is SendMessageLoading) {
          return LoadingMessageListView(messages: _messages);
        }
        return SizedBox.shrink();
      },
    );
  }
}
