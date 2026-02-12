class GeminiMessageEntity {
  final String text;
  final bool isFromUser;
  bool isFailed;

  GeminiMessageEntity({
    required this.text,
    required this.isFromUser,
    this.isFailed = false,
  });
}
