import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:second_chat_bot/features/home/presentation/manger/cubit/home_cubit.dart';
import 'package:second_chat_bot/features/home/presentation/views/widgets/build_chat_app_bar.dart';
import 'package:second_chat_bot/features/home/presentation/views/widgets/build_chat_bubble.dart';
import 'package:second_chat_bot/features/home/presentation/views/widgets/build_input_text.dart';
import 'package:second_chat_bot/features/home/presentation/views/widgets/build_suggetion_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final ScrollController _scrollController = ScrollController();

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildChatAppBar(context),
      backgroundColor: Colors.white,
      body: SafeArea(
        child: BlocBuilder<HomeCubit, HomeState>(
          builder: (context, state) {
            _scrollToBottom();

            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                children: [
                  Expanded(child: _buildBody(state)),
                  const BuildInputText(),
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
    if (state is HomeInitial) {
      return const SingleChildScrollView(child: BuildSuggetionWidget());
    } else if (state is HomeLoading) {
      return ListView.builder(
        controller: _scrollController,
        itemCount: context.read<HomeCubit>().messages.length + 1,
        itemBuilder: (context, index) {
          final messages = context.read<HomeCubit>().messages;
          if (index < messages.length) {
            final chatMessage = messages[index];
            return ChatBubble(
              isUser: chatMessage.isFromUser,
              message: chatMessage.text,
            );
          } else {
            return const ChatBubble(
              isUser: false,
              message: '',
              isLoading: true, // This triggers the dots
            );
          }
        },
      );
    } else if (state is HomeLoaded) {
      return ListView.builder(
        controller: _scrollController,
        itemCount: state.messages!.length,
        padding: const EdgeInsets.only(top: 10),
        itemBuilder: (context, index) {
          final chatMessage = state.messages![index];
          return ChatBubble(
            isUser: chatMessage.isFromUser,
            message: chatMessage.text,
            isLoading: false,
          );
        },
      );
    } else if (state is HomeError) {
      return ChatBubble(isUser: false, message: state.message);
    }
    return const SizedBox();
  }
}
