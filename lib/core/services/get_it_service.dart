import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:second_chat_bot/core/services/api/api_consumer.dart';
import 'package:second_chat_bot/core/services/api/dio_consumer.dart';

import 'package:second_chat_bot/features/chat/data/repos/chat_repo_impl.dart';
import 'package:second_chat_bot/features/chat/domain/repo/chat_repo.dart';

final getIt = GetIt.instance;

void setUpGetIt() async {
  // await Hive.initFlutter();
  // await Hive.openBox('appBox');

  // getIt.registerSingleton<AppStorage>(AppStorage());
  getIt.registerSingleton<ApiConsumer>(DioConsumer(dio: Dio()));
  getIt.registerSingleton<ChatRepo>(
    ChatRepoImpl(apiConsumer: getIt<ApiConsumer>()),
  );
}
