import 'package:flutter/material.dart';
import 'package:second_chat_bot/features/splash/presentation/view/splash_view.dart';

Route<dynamic> ongenerateRoute(RouteSettings settings) {
  switch (settings.name) {
    case SplashView.routeName:
      return MaterialPageRoute(builder: (_) => const SplashView());

    default:
      return MaterialPageRoute(builder: (_) => const Scaffold());
  }
}
