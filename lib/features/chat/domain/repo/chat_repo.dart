import 'package:dartz/dartz.dart';
import 'package:second_chat_bot/core/services/errors/server_excption.dart';

import 'package:second_chat_bot/features/chat/domain/entites/chat_entity.dart';

abstract class ChatRepo {
  Future<Either<ServerException, ChatEntity>> getGemineReponse({
    required List<ChatEntity> messages,
  });
}
