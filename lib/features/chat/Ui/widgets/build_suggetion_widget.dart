import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:second_chat_bot/features/chat/Ui/widgets/suggetion_catogry.dart';
import 'package:second_chat_bot/features/chat/Ui/widgets/suggetion_chip.dart';
import 'package:second_chat_bot/features/chat/data/models/chat_message_model.dart';

import 'package:second_chat_bot/features/chat/Ui/manger/cubit/chat_cubit.dart';

/// 1. Create a simple data model for your categories

class SuggestionWidget extends StatelessWidget {
  const SuggestionWidget({super.key, required this.messages});

  final List<ChatMessageModel> messages;

  /// 2. Move data out of the build method for better readability
  static const List<SuggestionCategory> _categories = [
    SuggestionCategory(
      icon: Icons.text_snippet,
      title: "Explain",
      items: [
        "Explain Quantum physics",
        "What are wormholes explain like i am 5",
      ],
    ),
    SuggestionCategory(
      icon: Icons.edit,
      title: "Write & edit",
      items: [
        "Write a tweet about global warming",
        "Write a poem about flower and love",
        "Write a rap song lyrics about space",
      ],
    ),
    SuggestionCategory(
      icon: Icons.translate,
      title: "Translate",
      items: [
        "How do you say \"how are you\" in korean?",
        "Translate 'I love programming' to German",
      ],
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 16),
      itemCount: _categories.length,
      separatorBuilder: (_, _) => const Gap(24),
      itemBuilder: (context, index) {
        return _SuggestionSection(
          category: _categories[index],
          onSuggestionTap: (text) => _handleSend(context, text),
        );
      },
    );
  }

  void _handleSend(BuildContext context, String text) {
    final message = ChatMessageModel.fromUserMessage(text);
    messages.add(message);
    context.read<SendMessageCubit>().sendMessage(messages: messages);
  }
}

/// 3. Extracted Section Widget
class _SuggestionSection extends StatelessWidget {
  final SuggestionCategory category;
  final Function(String) onSuggestionTap;

  const _SuggestionSection({
    required this.category,
    required this.onSuggestionTap,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(category.icon, size: 24, color: Colors.black54),
        const Gap(8),
        Text(
          category.title,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: Colors.black54,
          ),
        ),
        const Gap(12),
        ...category.items.map(
          (text) =>
              SuggestionChip(text: text, onTap: () => onSuggestionTap(text)),
        ),
      ],
    );
  }
}

/// 4. Extracted Chip Widget
