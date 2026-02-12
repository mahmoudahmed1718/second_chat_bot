import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:second_chat_bot/features/home/domain/entites/gemini_message_entity.dart';
import 'package:second_chat_bot/features/home/presentation/manger/cubit/home_cubit.dart';
import 'package:second_chat_bot/features/home/presentation/views/widgets/build_chat_app_bar.dart';
import 'package:second_chat_bot/features/home/presentation/views/widgets/build_chat_bubble.dart';
import 'package:second_chat_bot/features/home/presentation/views/widgets/build_input_text.dart';
import 'package:second_chat_bot/features/home/presentation/views/widgets/build_suggetion_widget.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});
  static const routeName = '/home';

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final ScrollController _scrollController = ScrollController();

  final List<GeminiMessageEntity> _messages = [];

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  void _sendMessage(String text) {
    if (text.trim().isEmpty) return;

    final userMessage = GeminiMessageEntity(text: text, isFromUser: true);

    _messages.add(userMessage);

    _scrollToBottom();

    context.read<HomeCubit>().getGemineReponse(messages: _messages);
  }

  void _retryMessage(GeminiMessageEntity message) {
    message.isFailed = false;

    context.read<HomeCubit>().getGemineReponse(messages: _messages);

    _scrollToBottom();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildChatAppBar(context),
      backgroundColor: Colors.white,
      body: SafeArea(
        child: BlocConsumer<HomeCubit, HomeState>(
          listener: (context, state) {
            if (state is HomeLoaded) {
              _messages.add(state.message);
              _scrollToBottom();
            }

            if (state is HomeError) {
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

  Widget _buildBody(HomeState state) {
    if (_messages.isEmpty && state is HomeInitial) {
      return SingleChildScrollView(
        child: BuildSuggetionWidget(onTap: _sendMessage),
      );
    }
    return ListView.builder(
      controller: _scrollController,
      padding: const EdgeInsets.only(top: 10),
      itemCount: _messages.length + (state is HomeLoading ? 1 : 0),
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
          return const ChatBubble(
            isUser: false,
            message: '',
            isLoading: true, // Show AI loading dots
          );
        }
      },
    );
  }
}
