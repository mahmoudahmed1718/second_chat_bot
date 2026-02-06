import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:second_chat_bot/features/home/domain/entites/gemini_message_entity.dart';
import 'package:second_chat_bot/features/home/domain/repo/get_gemine_reponse_repo.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  final GetGemineReponseRepo getGemineReponseRepo;

  // Keep track of messages in memory
  List<GeminiMessageEntity> messages = [];

  HomeCubit({required this.getGemineReponseRepo}) : super(HomeInitial());

  Future<void> getGemineReponse({required String message}) async {
    // 1. Add user message to history and emit loading
    messages.add(GeminiMessageEntity(text: message, isFromUser: true));
    emit(HomeLoading());

    // 2. Fetch AI response
    final result = await getGemineReponseRepo.getGemineReponse(
      message: message,
    );

    // 3. Handle result and emit new state
    result.fold((error) => emit(HomeError(message: error.toString())), (
      aiMessage,
    ) {
      messages.add(aiMessage);
      // Emit new state with updated list
      emit(HomeLoaded(messages: List.from(messages)));
    });
  }
}
