import 'package:flutter/material.dart';
import 'package:second_chat_bot/features/chat/Ui/views/chat_page.dart';
import 'package:second_chat_bot/features/splash/presentation/view/on_boarding_view.dart';
import 'package:second_chat_bot/features/splash/presentation/view/splash_view.dart';

Route<dynamic> ongenerateRoute(RouteSettings settings) {
  switch (settings.name) {
    case SplashView.routeName:
      return MaterialPageRoute(builder: (_) => const SplashView());
    case ChatPage.routeName:
      return MaterialPageRoute(builder: (_) => const ChatPage());
    case OnBoardingView.routeName:
      return MaterialPageRoute(builder: (_) => const OnBoardingView());
    default:
      return MaterialPageRoute(builder: (_) => const Scaffold());
  }
}
