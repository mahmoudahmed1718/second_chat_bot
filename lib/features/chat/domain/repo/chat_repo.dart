import 'package:dartz/dartz.dart';
import 'package:second_chat_bot/core/services/errors/server_excption.dart';
import 'package:second_chat_bot/features/chat/data/models/chat_message_model.dart';

abstract class ChatRepo {
  Future<Either<ServerException, ChatMessageModel>> sendMessage({
    required List<ChatMessageModel> messages,
  });
}
