import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:second_chat_bot/core/services/get_it_service.dart';
import 'package:second_chat_bot/features/home/domain/repo/get_gemine_reponse_repo.dart';
import 'package:second_chat_bot/features/home/presentation/manger/cubit/home_cubit.dart';
import 'package:second_chat_bot/features/home/presentation/views/home_page.dart';
import 'package:second_chat_bot/features/splash/presentation/view/on_boarding_view.dart';
import 'package:second_chat_bot/features/splash/presentation/view/splash_view.dart';

Route<dynamic> ongenerateRoute(RouteSettings settings) {
  switch (settings.name) {
    case SplashView.routeName:
      return MaterialPageRoute(builder: (_) => const SplashView());
    case HomeView.routeName:
      return MaterialPageRoute(
        builder: (_) => BlocProvider(
          create: (context) => HomeCubit(
            getGemineReponseRepo: getIt.get<GetGemineReponseRepo>(),
          ),
          child: const HomeView(),
        ),
      );
    case OnBoardingView.routeName:
      return MaterialPageRoute(builder: (_) => const OnBoardingView());
    default:
      return MaterialPageRoute(builder: (_) => const Scaffold());
  }
}
