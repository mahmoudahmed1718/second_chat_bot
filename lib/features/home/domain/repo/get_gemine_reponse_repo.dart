import 'package:dartz/dartz.dart';
import 'package:second_chat_bot/core/services/errors/server_excption.dart';

import 'package:second_chat_bot/features/home/domain/entites/gemini_message_entity.dart';

abstract class GetGemineReponseRepo {
  Future<Either<ServerException, GeminiMessageEntity>> getGemineReponse({
    required List<GeminiMessageEntity> messages,
  });
}
