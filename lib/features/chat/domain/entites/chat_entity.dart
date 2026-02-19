class ChatEntity {
  final String text;
  final bool isFromUser;
  bool isFailed;

  ChatEntity({
    required this.text,
    required this.isFromUser,
    this.isFailed = false,
  });
}
