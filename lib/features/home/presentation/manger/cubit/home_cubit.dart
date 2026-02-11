import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:second_chat_bot/features/home/domain/entites/gemini_message_entity.dart';
import 'package:second_chat_bot/features/home/domain/repo/get_gemine_reponse_repo.dart';
part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  final GetGemineReponseRepo getGemineReponseRepo;
  HomeCubit({required this.getGemineReponseRepo}) : super(HomeInitial());
  Future<void> getGemineReponse({
    required List<GeminiMessageEntity> messages,
  }) async {
    emit(HomeLoading());
    final result = await getGemineReponseRepo.getGemineReponse(
      messages: messages,
    );
    result.fold(
      (l) => emit(HomeError(errorMessage: l.errorModel.message.toString())),
      (r) => emit(HomeLoaded(message: r)),
    );
  }
}
