import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:second_chat_bot/core/utils/app_styel.dart';
import 'package:second_chat_bot/theme/app_colors.dart';

class BuildSuggetionWidget extends StatelessWidget {
  const BuildSuggetionWidget({super.key});
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Gap(18),
        _sectionIcon(Icons.text_snippet),
        _sectionTitle("Explain"),
        _suggestion("Explain Quantum physics"),
        _suggestion("What are wormholes explain like i am 5"),
        Gap(24),
        _sectionIcon(Icons.edit),
        _sectionTitle("Write & edit"),
        _suggestion("Write a tweet about global warming"),
        _suggestion("Write a poem about flower and love"),
        _suggestion("Write a rap song lyrics about"),
        Gap(24),
        _sectionIcon(Icons.translate),
        _sectionTitle("Translate"),
        _suggestion("How do you say \"how are you\" in korean?"),
        _suggestion("Write a poem about flower and love"),
      ],
    );
  }
}

// 🔹 Suggestion chip
Widget _suggestion(String text) {
  return InkWell(
    onTap: () async {
      // await HomeBloc.to.getReponseMessage(message: text);
    },
    child: Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      decoration: BoxDecoration(
        color: AppColors.accentColor,
        borderRadius: BorderRadius.circular(30),
      ),
      child: Row(
        children: [
          Expanded(
            child: Center(child: Text(text, style: AppStyles.fontStyle14)),
          ),
        ],
      ),
    ),
  );
}

Widget _sectionIcon(IconData iconData) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 8),
    child: Icon(iconData, size: 24, color: Colors.black54),
  );
}

Widget _sectionTitle(String title) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 8),
    child: Text(
      title,
      style: const TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w600,
        color: Colors.black54,
      ),
    ),
  );
}
