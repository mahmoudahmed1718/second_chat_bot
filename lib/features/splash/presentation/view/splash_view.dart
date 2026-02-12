import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:second_chat_bot/core/services/get_it_service.dart';
import 'package:second_chat_bot/core/utils/app_storage.dart';
import 'package:second_chat_bot/core/utils/assets.dart';
import 'package:second_chat_bot/features/chat/Ui/views/chat_page.dart';
import 'package:second_chat_bot/features/splash/presentation/view/on_boarding_view.dart';
import 'package:second_chat_bot/theme/app_colors.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});
  static const routeName = '/SplashPage';
  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  @override
  void initState() {
    super.initState();
    execute(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      body: Center(child: SvgPicture.asset(Assets.assetsImagesSplashImage)),
    );
  }

  Future<void> execute(BuildContext context) async {
    await Future.delayed(const Duration(seconds: 3));
    final appStorage = getIt.get<AppStorage>();
    final isOnboardingSeen = appStorage.getOnboardingSeen();

    if (isOnboardingSeen) {
      // ignore: use_build_context_synchronously
      Navigator.pushReplacementNamed(context, ChatView.routeName);
    } else {
      // ignore: use_build_context_synchronously
      Navigator.pushReplacementNamed(context, OnBoardingView.routeName);
    }
  }
}
