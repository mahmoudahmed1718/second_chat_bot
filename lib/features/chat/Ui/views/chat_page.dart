import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:second_chat_bot/core/services/get_it_service.dart';
import 'package:second_chat_bot/features/chat/Ui/manger/cubit/chat_cubit.dart';
import 'package:second_chat_bot/features/chat/Ui/widgets/build_chat_app_bar.dart';

import 'package:second_chat_bot/features/chat/Ui/widgets/messages_list_view_bloc_consumer.dart';
import 'package:second_chat_bot/features/chat/data/models/chat_message_model.dart';
import 'package:second_chat_bot/features/chat/data/repos/chat_repo_impl.dart';
import 'package:second_chat_bot/features/chat/data/services/gemine_chat_service.dart';

import '../../domain/repo/chat_repo.dart';
import '../widgets/build_input_text.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});
  static const routeName = '/home';

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final List<ChatMessageModel> _messages = [];

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SendMessageCubit(
        chatRepo: ChatRepoImpl(gemenaiChatService: getIt<GemenaiChatService>()),
      ),
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        appBar: buildChatAppBar(context),
        backgroundColor: Colors.white,
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: [
              Expanded(child: MessageListViewBlocConsumer(messages: _messages)),
              BuildInputText(messages: _messages),
              Gap(16),
            ],
          ),
        ),
      ),
    );
  }
}
