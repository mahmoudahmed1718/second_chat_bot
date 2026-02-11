import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:second_chat_bot/core/helper/on_generate_route.dart';
import 'package:second_chat_bot/core/services/custom_bloc_observer.dart';
import 'package:second_chat_bot/core/services/get_it_service.dart';
import 'package:second_chat_bot/features/splash/presentation/view/splash_view.dart';

void main() async {
  Bloc.observer = CustomBlocObserver();
  setUpGetIt();
  WidgetsFlutterBinding.ensureInitialized();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      onGenerateRoute: ongenerateRoute,
      initialRoute: SplashView.routeName,
    );
  }
}
