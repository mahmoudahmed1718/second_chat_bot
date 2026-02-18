part of 'chat_cubit.dart';

@immutable
sealed class SendMessageState {}

final class SendMessageInitial extends SendMessageState {}

final class SendMessageLoading extends SendMessageState {}

final class SendMessageLoaded extends SendMessageState {
  final GeminiMessageEntity message;

  SendMessageLoaded({required this.message});
}

final class SendMessageError extends SendMessageState {
  final String errorMessage;
  SendMessageError({required this.errorMessage});
}
