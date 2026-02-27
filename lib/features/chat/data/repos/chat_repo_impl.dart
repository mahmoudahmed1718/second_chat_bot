import 'package:dartz/dartz.dart';
import 'package:second_chat_bot/core/services/api/api_consumer.dart';
import 'package:second_chat_bot/core/services/api/end_points.dart';
import 'package:second_chat_bot/core/services/errors/error_model.dart';
import 'package:second_chat_bot/core/services/errors/server_excption.dart';
import 'package:second_chat_bot/features/chat/data/models/chat_message_model.dart';
import 'package:second_chat_bot/features/chat/data/repos/unit_tests/chat_input_vaildator.dart';
import 'package:second_chat_bot/features/chat/data/repos/unit_tests/chat_output_vaildator.dart';

import 'package:second_chat_bot/features/chat/domain/repo/chat_repo.dart';

class ChatRepoImpl implements ChatRepo {
  final ApiConsumer apiConsumer;

  ChatRepoImpl({required this.apiConsumer});

  @override
  Future<Either<ServerException, ChatMessageModel>> sendMessage({
    required List<ChatMessageModel> messages,
  }) async {
    ChatInputValidator.validateMessages(messages);
    try {
      final response = await apiConsumer.post(
        EndPoint.generateContent,
        data: {
          "contents": messages.map((message) => message.toJson()).toList(),
        },
      );
      final resultModel = ChatMessageModel.fromJson(response);

      ChatOutputValidator.validate(resultModel);
      return Right(resultModel);
    } on ArgumentError catch (e) {
      return Left(
        ServerException(
          errorModel: ErrorModel(message: e.message ?? 'Unknown error'),
        ),
      );
    } on ServerException catch (e) {
      return Left(e);
    }
  }
}
