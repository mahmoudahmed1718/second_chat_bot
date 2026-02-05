import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:second_chat_bot/core/utils/assets.dart';

class ChatBubble extends StatelessWidget {
  final bool isUser;
  final String message; // Change this from GemineModel to String

  const ChatBubble({
    super.key,
    required this.isUser,
    required this.message, // Use the String here
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
              color: isUser ? const Color(0xFF2F66F6) : const Color(0xFFF1F1F1),
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
            child: Text(
              message, // Use the string directly
              style: TextStyle(
                color: isUser ? Colors.white : Colors.black87,
                fontSize: 14,
                height: 1.4,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
