import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:second_chat_bot/features/home/domain/entites/gemini_message_entity.dart';
import 'package:second_chat_bot/features/home/domain/repo/get_gemine_reponse_repo.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  final GetGemineReponseRepo getGemineReponseRepo;

  List<GeminiMessageEntity> messages = [];

  HomeCubit({required this.getGemineReponseRepo}) : super(HomeInitial());

  Future<void> getGemineReponse({required String message}) async {
    messages.add(GeminiMessageEntity(text: message, isFromUser: true));
    emit(HomeLoading());

    final result = await getGemineReponseRepo.getGemineReponse(
      message: message,
    );
    result.fold((error) => emit(HomeError(message: error.toString())), (
      aiMessage,
    ) {
      messages.add(aiMessage);
      emit(HomeLoaded(messages: List.from(messages)));
    });
  }
}
