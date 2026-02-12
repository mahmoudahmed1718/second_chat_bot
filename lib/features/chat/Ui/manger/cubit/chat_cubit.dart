import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:second_chat_bot/features/chat/domain/entites/gemini_message_entity.dart';
import 'package:second_chat_bot/features/chat/domain/repo/get_gemine_reponse_repo.dart';
part 'chat_state.dart';

class ChatCubit extends Cubit<ChatState> {
  final GetGemineReponseRepo getGemineReponseRepo;
  ChatCubit({required this.getGemineReponseRepo}) : super(ChatInitial());
  Future<void> getGemineReponse({
    required List<GeminiMessageEntity> messages,
  }) async {
    emit(ChatLoading());
    final result = await getGemineReponseRepo.getGemineReponse(
      messages: messages,
    );
    result.fold(
      (l) => emit(ChatError(errorMessage: l.errorModel.message.toString())),
      (r) => emit(ChatLoaded(message: r)),
    );
  }
}
