import 'package:second_chat_bot/features/chat/data/repos/unit_tests/chat_input_vaildator.dart';
import 'package:second_chat_bot/features/chat/data/repos/unit_tests/chat_output_vaildator.dart';
import 'package:second_chat_bot/features/chat/data/services/gemine_chat_service.dart';
import 'package:second_chat_bot/features/chat/domain/repo/chat_repo.dart';

import '../models/chat_message_model.dart';

class ChatRepoImpl extends ChatRepo {
  final GemenaiChatService _gemenaiChatService;

  ChatRepoImpl({required GemenaiChatService gemenaiChatService})
    : _gemenaiChatService = gemenaiChatService;
  @override
  Future<ChatMessageModel> sendMessage({
    required List<ChatMessageModel> messages,
  }) async {
    ChatInputValidator.validateMessages(messages);
    ChatOutputValidator.validate(messages.last);
    return _gemenaiChatService.sendMessage(messages: messages);
  }
}
