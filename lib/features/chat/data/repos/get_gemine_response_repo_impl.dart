import 'package:dartz/dartz.dart';
import 'package:second_chat_bot/core/services/api/api_consumer.dart';
import 'package:second_chat_bot/core/services/api/end_points.dart';
import 'package:second_chat_bot/core/services/errors/server_excption.dart';
import 'package:second_chat_bot/features/chat/data/models/gemine_reponse/gemine_reponse.dart';
import 'package:second_chat_bot/features/chat/data/models/gemine_request/gemine_requset/gemine_requset.dart';
import 'package:second_chat_bot/features/chat/data/models/gemine_request/gemine_requset/content.dart';
import 'package:second_chat_bot/features/chat/data/models/gemine_request/gemine_requset/part.dart';
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
      final request = GemineRequset(
        contents: messages.map((e) {
          return Content(parts: [Part(text: e.text)]);
        }).toList(),
      );

      final response = await apiConsumer.post(
        EndPoint.generateContent,
        data: request.toJson(),
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
