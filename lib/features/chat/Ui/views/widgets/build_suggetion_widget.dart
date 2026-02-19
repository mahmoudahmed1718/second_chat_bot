import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:second_chat_bot/core/utils/app_styel.dart';
import 'package:second_chat_bot/features/chat/domain/entites/gemini_message_entity.dart';
import 'package:second_chat_bot/features/chat/Ui/manger/cubit/chat_cubit.dart';
import 'package:second_chat_bot/theme/app_colors.dart';

/// 1. Create a simple data model for your categories
class SuggestionCategory {
  final String title;
  final IconData icon;
  final List<String> items;

  const SuggestionCategory({
    required this.title,
    required this.icon,
    required this.items,
  });
}

class SuggestionWidget extends StatelessWidget {
  const SuggestionWidget({super.key, required this.messages});

  final List<GeminiMessageEntity> messages;

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
      separatorBuilder: (_, __) => const Gap(24),
      itemBuilder: (context, index) {
        return _SuggestionSection(
          category: _categories[index],
          onSuggestionTap: (text) => _handleSend(context, text),
        );
      },
    );
  }

  void _handleSend(BuildContext context, String text) {
    final message = GeminiMessageEntity(text: text, isFromUser: true);
    messages.add(message);
    context.read<SendMessageCubit>().getGemineReponse(messages: messages);
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
              _SuggestionChip(text: text, onTap: () => onSuggestionTap(text)),
        ),
      ],
    );
  }
}

/// 4. Extracted Chip Widget
class _SuggestionChip extends StatelessWidget {
  final String text;
  final VoidCallback onTap;

  const _SuggestionChip({required this.text, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(30),
      child: Container(
        width:
            double.infinity, // Ensures all chips have the same width if desired
        margin: const EdgeInsets.only(bottom: 10),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        decoration: BoxDecoration(
          color: AppColors.accentColor,
          borderRadius: BorderRadius.circular(30),
        ),
        child: Text(
          text,
          style: AppStyles.fontStyle14,
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
