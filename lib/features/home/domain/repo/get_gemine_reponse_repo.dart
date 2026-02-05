import 'package:dartz/dartz.dart';
import 'package:second_chat_bot/core/errors/server_excption.dart';
import 'package:second_chat_bot/features/home/data/models/gemine_reponse/gemine_reponse.dart';

abstract class GetGemineReponseRepo {
  Future<Either<ServerExcption, GemineReponse>> getGemineReponse();
}
