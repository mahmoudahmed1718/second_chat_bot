import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:second_chat_bot/core/utils/assets.dart';

class ChatBubble extends StatelessWidget {
  final bool isUser;
  final String message;
  final bool isLoading; // NEW: Track loading state

  const ChatBubble({
    super.key,
    required this.isUser,
    required this.message,
    this.isLoading = false, // NEW: Default to false
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
            // FIX: Conditionally show loading dots or text
            child: isLoading
                ? const LoadingDots()
                : Text(
                    message,
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

// NEW: Helper widget to animate three dots
class LoadingDots extends StatefulWidget {
  const LoadingDots({super.key});

  @override
  State<LoadingDots> createState() => _LoadingDotsState();
}

class _LoadingDotsState extends State<LoadingDots>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(3, (index) {
        return FadeTransition(
          opacity: DelayTween(
            begin: 0.0,
            end: 1.0,
            delay: index * 0.2,
          ).animate(_controller),
          child: const Text(
            ".",
            style: TextStyle(color: Colors.black54, fontSize: 16),
          ),
        );
      }),
    );
  }
}

// Helper class for staggered animation
class DelayTween extends Tween<double> {
  final double delay;

  DelayTween({required double begin, required double end, required this.delay})
    : super(begin: begin, end: end);

  @override
  double lerp(double t) {
    return super.lerp((t - delay).clamp(0.0, 1.0));
  }
}
