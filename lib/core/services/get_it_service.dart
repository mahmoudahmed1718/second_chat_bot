import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:second_chat_bot/core/services/api/api_consumer.dart';
import 'package:second_chat_bot/core/services/api/dio_consumer.dart';
import 'package:second_chat_bot/features/home/data/repos/get_gemine_response_repo_impl.dart';
import 'package:second_chat_bot/features/home/domain/repo/get_gemine_reponse_repo.dart';

final getIt = GetIt.instance;

void setUpGetIt() {
  getIt.registerSingleton<ApiConsumer>(DioConsumer(dio: Dio()));

  getIt.registerSingleton<GetGemineReponseRepo>(
    GetGemineResponseRepoImpl(apiConsumer: getIt<ApiConsumer>()),
  );
}
