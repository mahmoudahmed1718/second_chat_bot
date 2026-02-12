import 'package:dartz/dartz.dart';
import 'package:second_chat_bot/core/services/api/api_consumer.dart';
import 'package:second_chat_bot/core/services/api/end_points.dart';
import 'package:second_chat_bot/core/services/errors/server_excption.dart';
import 'package:second_chat_bot/features/chat/data/models/gemine_reponse/gemine_reponse.dart';
import 'package:second_chat_bot/features/chat/domain/entites/gemini_message_entity.dart';
import 'package:second_chat_bot/features/chat/domain/repo/get_gemine_reponse_repo.dart';

class GetGemineResponseRepoImpl implements GetGemineReponseRepo {
  final ApiConsumer apiConsumer;

  GetGemineResponseRepoImpl({required this.apiConsumer});

  @override
  Future<Either<ServerException, GeminiMessageEntity>> getGemineReponse({
    required List<GeminiMessageEntity> messages,
  }) async {
    try {
      final response = await apiConsumer.post(
        EndPoint.generateContent,
        data: {
          "contents": messages.map((e) {
            return {
              "role": e.isFromUser ? "user" : "model",
              "parts": [
                {"text": e.text},
              ],
            };
          }).toList(),
        },
      );

      final gemineResponseModel = GemineReponse.fromJson(response);

      final GeminiMessageEntity entity = GeminiMessageEntity(
        text:
            gemineResponseModel.candidates?.first.content?.parts?.first.text ??
            '',
        isFromUser: false,
      );

      return Right(entity);
    } on ServerException catch (e) {
      return Left(e);
    }
  }
}
