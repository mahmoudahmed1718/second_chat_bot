import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:second_chat_bot/core/services/custom_bloc_observer.dart';
import 'package:second_chat_bot/core/services/get_it_service.dart';
import 'package:second_chat_bot/features/home/domain/repo/get_gemine_reponse_repo.dart';
import 'package:second_chat_bot/features/home/presentation/manger/cubit/home_cubit.dart';
import 'package:second_chat_bot/features/home/presentation/views/home_page.dart';

void main() {
  Bloc.observer = CustomBlocObserver();
  WidgetsFlutterBinding.ensureInitialized();
  setUpGetIt();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: BlocProvider(
        create: (context) =>
            HomeCubit(getGemineReponseRepo: getIt<GetGemineReponseRepo>()),
        child: HomePage(),
      ),
    );
  }
}
