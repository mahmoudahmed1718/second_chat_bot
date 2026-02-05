import 'package:flutter/material.dart';
import 'package:second_chat_bot/theme/app_colors.dart';

abstract class AppStyles {
  static const fontStyle23 = TextStyle(
    fontSize: 23,
    fontFamily: 'Nunito',
    fontWeight: FontWeight.bold,
    color: AppColors.primaryColor,
  );
  static const fontStyle14 = TextStyle(
    fontSize: 14,
    fontFamily: 'Nunito',
    fontWeight: FontWeight.w500,
  );
  static const fontStyle15 = TextStyle(
    fontSize: 15,
    fontFamily: 'Nunito',
    fontWeight: FontWeight.w500,
    color: Color(0XFF757575),
  );
  static const fontStyle13 = TextStyle(
    fontSize: 13,
    fontFamily: 'Nunito',
    fontWeight: FontWeight.w700,
  );
}
