class GeminiMessageEntity {
  final String text;
  final bool isFromUser;

  const GeminiMessageEntity({required this.text, required this.isFromUser});
}

class GeminiMessageEntityList {
  final List<GeminiMessageEntity> messages;
  GeminiMessageEntityList({required this.messages});
}
