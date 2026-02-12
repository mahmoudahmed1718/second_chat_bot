import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:second_chat_bot/core/utils/assets.dart';
import 'package:second_chat_bot/features/home/presentation/views/widgets/loading_dots.dart';

class ChatBubble extends StatelessWidget {
  final bool isUser;
  final String message;
  final bool isLoading;
  final bool isFailed;
  final VoidCallback? onRetry;

  const ChatBubble({
    super.key,
    required this.isUser,
    required this.message,
    this.isFailed = false,
    this.isLoading = false,
    this.onRetry,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: isUser
            ? MainAxisAlignment.end
            : MainAxisAlignment.start,
        children: [
          if (!isUser)
            SvgPicture.asset(
              Assets.assetsImagesRebotImage,
              height: 17.17,
              width: 11,
            ),
          const Gap(6),
          Container(
            margin: const EdgeInsets.symmetric(vertical: 6),
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
            constraints: BoxConstraints(
              maxWidth: MediaQuery.of(context).size.width * 0.75,
            ),
            decoration: BoxDecoration(
              color: _getBubbleColor(),
              borderRadius: BorderRadius.only(
                topLeft: const Radius.circular(18),
                topRight: const Radius.circular(18),
                bottomLeft: isUser
                    ? const Radius.circular(18)
                    : const Radius.circular(4),
                bottomRight: isUser
                    ? const Radius.circular(4)
                    : const Radius.circular(18),
              ),
            ),
            child: _buildContent(context),
          ),
        ],
      ),
    );
  }

  Color _getBubbleColor() {
    if (isFailed) return Colors.red.shade400;
    return isUser ? const Color(0xFF2F66F6) : const Color(0xFFF1F1F1);
  }

  Widget _buildContent(BuildContext context) {
    if (isLoading) {
      return const LoadingDots();
    }

    if (isFailed) {
      return Column(
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
      );
    }

    return Text(
      message,
      style: TextStyle(
        color: isUser ? Colors.white : Colors.black87,
        fontSize: 14,
        height: 1.4,
      ),
    );
  }
}
