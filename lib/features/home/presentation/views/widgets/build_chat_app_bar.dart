import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:second_chat_bot/core/utils/app_styel.dart';
import 'package:second_chat_bot/core/utils/assets.dart';

AppBar buildChatAppBar(BuildContext context) {
  return AppBar(
    title: Row(
      children: [
        Gap(16),
        SvgPicture.asset(Assets.assetsImagesRebotImage),
        Gap(16),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Text("ChatGPT", style: AppStyles.fontStyle23),
            SizedBox(height: 2),
            Row(
              children: [
                Icon(Icons.circle, size: 8, color: Colors.green),
                SizedBox(width: 4),
                Text(
                  "Online",
                  style: TextStyle(fontSize: 17, color: Colors.green),
                ),
              ],
            ),
          ],
        ),
      ],
    ),
    actions: [
      IconButton(
        icon: Icon(Icons.volume_up, color: Colors.black),
        onPressed: () {},
      ),
      IconButton(
        icon: const Icon(Icons.upload, color: Colors.grey),
        onPressed: () {},
      ),
    ],
  );
}
