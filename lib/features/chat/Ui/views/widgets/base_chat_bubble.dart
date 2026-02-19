import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:second_chat_bot/core/utils/assets.dart';

class BaseChatBubble extends StatelessWidget {
  const BaseChatBubble({
    required this.isUser,
    required this.color,
    required this.child,
    super.key,
  });
  final bool isUser;
  final Color color;
  final Widget child;

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
            Padding(
              padding: const EdgeInsets.only(right: 6),
              child: SvgPicture.asset(
                Assets.assetsImagesRebotImage,
                height: 17.17,
                width: 11,
              ),
            ),
          Container(
            margin: const EdgeInsets.symmetric(vertical: 6),
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
            constraints: BoxConstraints(
              maxWidth: MediaQuery.of(context).size.width * 0.75,
            ),
            decoration: BoxDecoration(
              color: color,
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
            child: child,
          ),
        ],
      ),
    );
  }
}
