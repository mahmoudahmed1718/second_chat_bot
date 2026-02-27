part of 'chat_cubit.dart';

@immutable
sealed class SendMessageState {}

final class SendMessageInitial extends SendMessageState {}

final class SendMessageLoading extends SendMessageState {}

final class SendMessageLoaded extends SendMessageState {
  final ChatMessageModel messageModel;
  SendMessageLoaded({required this.messageModel});
}

final class SendMessageError extends SendMessageState {
  final String errorMessage;
  SendMessageError({required this.errorMessage});
}
