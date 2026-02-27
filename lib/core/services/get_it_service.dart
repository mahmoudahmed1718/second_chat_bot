import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:second_chat_bot/core/services/api/api_client.dart';
import 'package:second_chat_bot/features/chat/data/services/gemine_chat_service.dart';

final getIt = GetIt.instance;

void setUpGetIt() async {
  // await Hive.initFlutter();
  // await Hive.openBox('appBox');

  getIt.registerSingleton<Dio>(Dio());
  getIt.registerSingleton<DioApiClient>(
    DioApiClient(
      baseUrl: 'https://generativelanguage.googleapis.com/v1beta/models',
    ),
  );
  getIt.registerSingleton<GemenaiChatService>(
    GemenaiChatService(apiClient: getIt<DioApiClient>()),
  );
}
