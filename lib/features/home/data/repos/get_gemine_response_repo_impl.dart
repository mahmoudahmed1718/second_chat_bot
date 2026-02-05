import 'package:dartz/dartz.dart';
import 'package:second_chat_bot/core/services/api/dio_consumer.dart';
import 'package:second_chat_bot/core/services/api/end_points.dart';
import 'package:second_chat_bot/core/services/errors/server_excption.dart';
import 'package:second_chat_bot/features/home/data/models/gemine_reponse/gemine_reponse.dart';
import 'package:second_chat_bot/features/home/domain/entites/gemini_message_entity.dart';
import 'package:second_chat_bot/features/home/domain/repo/get_gemine_reponse_repo.dart';

class GetGemineResponseRepoImpl implements GetGemineReponseRepo {
  final DioConsumer dioConsumer;

  GetGemineResponseRepoImpl(this.dioConsumer);

  @override
  Future<Either<ServerExcption, GeminiMessageEntity>> getGemineReponse({
    required String message,
  }) async {
    try {
      final response = await dioConsumer.post(
        EndPoint.generateContent,
        data: {
          "contents": [
            {
              "parts": [
                {"text": message},
              ],
            },
          ],
        },
      );
      // FIX: Parse the response into your Data Model
      final gemineResponseModel = GemineReponse.fromJson(response);

      // FIX: Map the Data Model to the Entity
      // Assuming your GemineReponse has a method to map to the entity,
      // or you do it manually here:
      final GeminiMessageEntity entity = GeminiMessageEntity(
        text:
            gemineResponseModel.candidates?.first.content?.parts?.first.text ??
            '', // Adjust based on your model's structure
        isFromUser: false,
      );

      return Right(entity);
    } on ServerExcption catch (e) {
      return Left(e);
    }
  }
}
