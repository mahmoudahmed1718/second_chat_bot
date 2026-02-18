import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:second_chat_bot/features/chat/domain/entites/gemini_message_entity.dart';
import 'package:second_chat_bot/features/chat/Ui/manger/cubit/chat_cubit.dart';
import 'package:second_chat_bot/features/chat/Ui/views/widgets/build_chat_app_bar.dart';
import 'package:second_chat_bot/features/chat/Ui/views/widgets/build_chat_bubble.dart';
import 'package:second_chat_bot/features/chat/Ui/views/widgets/build_input_text.dart';
import 'package:second_chat_bot/features/chat/Ui/views/widgets/build_suggetion_widget.dart';

class ChatView extends StatefulWidget {
  const ChatView({super.key});
  static const routeName = '/home';

  @override
  State<ChatView> createState() => _ChatViewState();
}

class _ChatViewState extends State<ChatView> {
  final ScrollController _scrollController = ScrollController();
  final List<GeminiMessageEntity> _messages = [];

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: buildChatAppBar(context),
      backgroundColor: Colors.white,
      body: SafeArea(
        child: BlocConsumer<ChatCubit, ChatState>(
          listener: (context, state) {
            if (state is ChatLoaded) {
              _messages.add(state.message);
              _scrollToBottom();
            }

            if (state is ChatError) {
              if (_messages.isNotEmpty) {
                _messages.last.isFailed = true;
              }

              ScaffoldMessenger.of(
                context,
              ).showSnackBar(SnackBar(content: Text(state.errorMessage)));
            }
          },
          builder: (context, state) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                children: [
                  Expanded(child: _buildBody(state)),
                  BuildInputText(onSend: _sendMessage),
                  const Gap(16),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildBody(ChatState state) {
    if (_messages.isEmpty && state is ChatInitial) {
      return SingleChildScrollView(
        child: BuildSuggetionWidget(onTap: _sendMessage),
      );
    }

    return ListView.builder(
      controller: _scrollController,
      padding: const EdgeInsets.only(top: 10, bottom: 10),
      itemCount: _messages.length + (state is ChatLoading ? 1 : 0),
      itemBuilder: (context, index) {
        if (index < _messages.length) {
          final chatMessage = _messages[index];

          return ChatBubble(
            isUser: chatMessage.isFromUser,
            message: chatMessage.text,
            isFailed: chatMessage.isFailed,
            onRetry: chatMessage.isFailed
                ? () => _retryMessage(chatMessage)
                : null,
          );
        } else {
          return const ChatBubble(isUser: false, message: '', isLoading: true);
        }
      },
    );
  }

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 250),
          curve: Curves.easeOut,
        );
      }
    });
  }

  void _sendMessage(String text) {
    if (text.trim().isEmpty) return;

    final userMessage = GeminiMessageEntity(text: text, isFromUser: true);

    _messages.add(userMessage);

    context.read<ChatCubit>().getGemineReponse(messages: _messages);

    _scrollToBottom();
  }

  void _retryMessage(GeminiMessageEntity message) {
    message.isFailed = false;

    context.read<ChatCubit>().getGemineReponse(messages: _messages);

    _scrollToBottom();
  }
}
