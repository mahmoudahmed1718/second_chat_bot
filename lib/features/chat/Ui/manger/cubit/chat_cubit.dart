import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:second_chat_bot/features/chat/data/models/chat_message_model.dart';

import 'package:second_chat_bot/features/chat/domain/repo/chat_repo.dart';
part 'chat_state.dart';

class SendMessageCubit extends Cubit<SendMessageState> {
  final ChatRepo getGemineReponseRepo;
  SendMessageCubit({required this.getGemineReponseRepo})
    : super(SendMessageInitial());
  Future<void> sendMessage({required List<ChatMessageModel> messages}) async {
    emit(SendMessageLoading());
    final result = await getGemineReponseRepo.sendMessage(messages: messages);
    result.fold(
      (l) =>
          emit(SendMessageError(errorMessage: l.errorModel.message.toString())),
      (r) => emit(SendMessageLoaded(messageModel: r)),
    );
  }
}
