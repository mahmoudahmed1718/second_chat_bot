import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:second_chat_bot/core/services/get_it_service.dart';
import 'package:second_chat_bot/core/utils/app_storage.dart';
import 'package:second_chat_bot/core/utils/app_styel.dart';
import 'package:second_chat_bot/core/utils/assets.dart';
import 'package:second_chat_bot/features/chat/Ui/views/chat_page.dart';
import 'package:second_chat_bot/theme/app_colors.dart';

class OnBoardingView extends StatelessWidget {
  const OnBoardingView({super.key});
  static const routeName = '/onboarding';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Gap(79),
                Text('You Ai Assistant', style: AppStyles.fontStyle23),
                Gap(14),
                const Text(
                  'Using this software, you can ask you\nquestions and receive articles using\nartificial intelligence assistant',
                  textAlign: TextAlign.center,
                  maxLines: 3,
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.grey,
                    height: 1.5, // Line height for readability
                  ),
                ),

                // Illustration Placeholder
                // Replace with Image.asset('assets/illustration.png')
                Gap(84),
                Image.asset(Assets.assetsImagesOnBoardPngImage),

                Gap(130),
                SizedBox(
                  width: double.infinity,
                  height: 56,
                  child: ElevatedButton(
                    onPressed: () {
                      final appStorage = getIt.get<AppStorage>();
                      appStorage.setOnboardingSeen();
                      Navigator.pushReplacementNamed(
                        context,
                        ChatPage.routeName,
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primaryColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    child: const Stack(
                      alignment: Alignment.center,
                      children: [
                        Text(
                          'Continue',
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Align(
                          alignment: Alignment.centerRight,
                          child: Icon(Icons.arrow_forward, color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                ),
                Gap(40),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
