import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:second_chat_bot/features/chat/domain/entites/gemini_message_entity.dart';
import 'package:second_chat_bot/features/chat/domain/repo/get_gemine_reponse_repo.dart';
part 'chat_state.dart';

class SendMessageCubit extends Cubit<SendMessageState> {
  final GetGemineReponseRepo getGemineReponseRepo;
  SendMessageCubit({required this.getGemineReponseRepo})
    : super(SendMessageInitial());
  Future<void> getGemineReponse({
    required List<GeminiMessageEntity> messages,
  }) async {
    emit(SendMessageLoading());
    final result = await getGemineReponseRepo.getGemineReponse(
      messages: messages,
    );
    result.fold(
      (l) =>
          emit(SendMessageError(errorMessage: l.errorModel.message.toString())),
      (r) => emit(SendMessageLoaded(message: r)),
    );
  }
}
