import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:second_chat_bot/features/chat/Ui/views/widgets/base_chat_bubble.dart';

class FailedBubble extends StatelessWidget {
  final String message;
  final VoidCallback? onRetry;

  const FailedBubble({super.key, required this.message, this.onRetry});

  @override
  Widget build(BuildContext context) {
    return BaseChatBubble(
      isUser: true,
      color: Colors.red.shade400,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            message,
            style: const TextStyle(color: Colors.white, fontSize: 14),
          ),
          const Gap(6),
          GestureDetector(
            onTap: onRetry,
            child: const Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.refresh, color: Colors.white, size: 16),
                Gap(4),
                Text(
                  "Retry",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
