import 'package:flutter/material.dart';
import 'package:second_chat_bot/core/utils/app_styel.dart';
import 'package:second_chat_bot/theme/app_colors.dart';

class SuggestionChip extends StatelessWidget {
  final String text;
  final VoidCallback onTap;

  const SuggestionChip({super.key, required this.text, required this.onTap});

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
