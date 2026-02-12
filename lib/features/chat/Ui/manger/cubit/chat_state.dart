part of 'chat_cubit.dart';

@immutable
sealed class ChatState {}

final class ChatInitial extends ChatState {}

final class ChatLoading extends ChatState {}

final class ChatLoaded extends ChatState {
  final GeminiMessageEntity message;

  ChatLoaded({required this.message});
}

final class ChatError extends ChatState {
  final String errorMessage;
  ChatError({required this.errorMessage});
}
